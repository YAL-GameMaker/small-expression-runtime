var stack = argument0;
var b = ds_stack_pop(stack);
var a = ds_stack_pop(stack);
if (!(is_real(a) || is_int64(a) || is_bool(a))
	|| !(is_real(b) || is_int64(b) || is_bool(b))
) return "Can't operate on "
	+ string(a) + "(" + typeof(a) + ") and "
	+ string(b) + "(" + typeof(b) + ")";
var k = argument1;
// switch() block comparisons are currently O(n) on VM,
// therefore a nested switch is used instead.
switch (k >> 4) {
	case 0x0: switch (k) {
		case sxr_op_mul: a *= b; break;
		case sxr_op_div:
			if (b == 0) {
				return "Division by zero";
			} else a /= b;
			break;
		case sxr_op_mod:
			if (b == 0) {
				return "Division by zero";
			} else a %= b;
			break
		case sxr_op_idiv:
			if (b == 0) {
				return "Division by zero";
			} else a = a div b;
			break
		}; break;
	case 0x1: switch (k) {
		case sxr_op_add: a += b; break;
		case sxr_op_sub: a -= b; break;
	}; break;
	case 0x2: switch (k) {
		case sxr_op_shl: a = a << b; break;
		case sxr_op_shr: a = a >> b; break;
	}; break;
	case 0x3: switch (k) {
		case sxr_op_or: a |= b; break;
		case sxr_op_and: a &= b; break;
		case sxr_op_xor: a ^= b; break;
	}; break;
	case 0x4: switch (k) {
		case sxr_op_eq: a = (a == b); break;
		case sxr_op_ne: a = (a != b); break;
		case sxr_op_lt: a = (a < b); break;
		case sxr_op_gt: a = (a > b); break;
		case sxr_op_le: a = (a <= b); break;
		case sxr_op_ge: a = (a >= b); break;
	}; break;
	case 0x5: switch (k) {
		case sxr_op_band: a = a && b; break;
		case sxr_op_bor: a = a || b; break;
	}; break;
} // switch (k >> 4)
ds_stack_push(stack, a);
return "";