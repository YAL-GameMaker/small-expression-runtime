/// @arg expr
// This script attempts to optimize expressions at compile-time.
// So, for example, if you had `(2 + 3) * -4`, that'll be changed to
// `5 * -4` and then to `-20`. It'll also execute functions which
// were marked as static. This is similar to what GM itself does.
var q = argument0;
var a, b, w, i, n, z;
switch (q[0]) {
	case sxr_node_unop:
		a = q[3]; if (sxr_optimize_expr(a)) return true;
		if (a[0] == sxr_node_number) {
			switch (q[2]) {
				case sxr_unop_bit: q[@2] = ~a[2]; break;
				case sxr_unop_log: q[@2] = !a[2]; break;
				case sxr_unop_dec: q[@2] = -a[2]; break;
			}
			q[@0] = sxr_node_number;
		}
		break;
	case sxr_node_binop:
		a = q[3]; if (sxr_optimize_expr(a)) return true;
		b = q[4]; if (sxr_optimize_expr(b)) return true;
		switch (a[0]) {
			case sxr_node_number:
				if (b[0] != sxr_node_number) break;
				switch (q[2]) {
					case sxr_op_add: q[@2] = a[2] + b[2]; break;
					case sxr_op_sub: q[@2] = a[2] - b[2]; break;
					case sxr_op_mul: q[@2] = a[2] * b[2]; break;
					case sxr_op_div:
						if (b[2] == 0) return sxr_compile_exit("Division by zero", q);
						q[@2] = a[2] / b[2];
						break;
					case sxr_op_mod:
						if (b[2] == 0) return sxr_compile_exit("Division by zero", q);
						q[@2] = a[2] % b[2];
						break;
					case sxr_op_idiv:
						if (b[2] == 0) return sxr_compile_exit("Division by zero", q);
						q[@2] = a[2] div b[2];
						break;
					case sxr_op_shl: q[@2] = a[2] << b[2]; break;
					case sxr_op_shr: q[@2] = a[2] >> b[2]; break;
					case sxr_op_and: q[@2] = a[2] & b[2]; break;
					case sxr_op_or: q[@2] = a[2] | b[2]; break;
					case sxr_op_xor: q[@2] = a[2] ^ b[2]; break;
					case sxr_op_eq: q[@2] = a[2] == b[2]; break;
					case sxr_op_ne: q[@2] = a[2] != b[2]; break;
					case sxr_op_lt: q[@2] = a[2] < b[2]; break;
					case sxr_op_gt: q[@2] = a[2] > b[2]; break;
					case sxr_op_le: q[@2] = a[2] <= b[2]; break;
					case sxr_op_ge: q[@2] = a[2] >= b[2]; break;
					case sxr_op_band: q[@2] = a[2] && b[2]; break;
					case sxr_op_bor: q[@2] = a[2] || b[2]; break;
					default: return false;
				}
				q[@0] = sxr_node_number;
				q[@3] = undefined;
				q[@4] = undefined;
				break;
			case sxr_node_string:
				if (b[0] != sxr_node_string) break;
				switch (q[2]) {
					case sxr_op_add:
						q[@0] = sxr_node_string;
						q[@2] = a[2] + b[2];
						break;
					case sxr_op_eq:
						q[@0] = sxr_node_number;
						q[@2] = a[2] == b[2];
						break;
					case sxr_op_ne:
						q[@0] = sxr_node_number;
						q[@2] = a[2] != b[2];
						break;
					default: return false;
				}
				break;
		}
		break;
	case sxr_node_call:
		w = q[3]; // arguments
		n = array_length_1d(w);
		z = q[5]; // can be optimized if it's a static function call
		
		// firstly, we attempt to optimize function's arguments:
		for (i = 0; i < n; i++) {
			a = w[i];
			if (sxr_optimize_expr(a)) return true;
			
			// if function call is still a candidate for optimization, verify that
			// the argument is a constant value, and unmark it if it isn't:
			if (z) switch (a[0]) {
				case sxr_node_number:
				case sxr_node_string:
				case sxr_node_undefined:
					break;
				default: z = false;
			}
		}
		
		if (z) { // if the function can indeed be optimized out,
		    // we form a stack for a runtime-like call,
			i = n;
			b = ds_stack_create();
			while (--i >= 0) {
				a = w[i];
				switch (a[0]) {
					case sxr_node_number: ds_stack_push(b, a[2]); break;
					case sxr_node_string: ds_stack_push(b, a[2]); break;
					default: ds_stack_push(b, undefined); // (we have no other types so it is)
				}
			}
			
			// call the function,
			sxr_exec_error = "";
			a = sxr_exec_call(q[2], b, n);
			
			// verify that this didn't throw up an error,
			if (a != "") {
				ds_stack_destroy(b);
				return sxr_compile_exit(sxr_exec_error, q);
			} else {
				a = ds_stack_pop(b);
				ds_stack_destroy(b);
			}
			
			// and replace the function with the appropriate AST node for the value:
			if (is_real(a) || is_int64(a) || is_bool(a)) {
				q[@0] = sxr_node_number;
				q[@2] = a;
			} else if (is_string(a)) {
				q[@0] = sxr_node_string;
				q[@2] = a;
			} else if (a == undefined) {
				q[@0] = sxr_node_undefined;
				q[@2] = undefined;
			} else return sxr_compile_exit("Can't inline " + string(a) + " (" + typeof(a) + ")", q);
			
			// (and also reset now-unused tail arguments because we can't shrink arrays)
			for (i = 3; i <= 5; i++) q[@i] = undefined;
		}
		break;
}
return false;