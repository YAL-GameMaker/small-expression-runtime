#macro sxr_build_no_ops 1
#macro sxr_build_no_sfx 2
#macro sxr_build_curr sxr_build_tks[sxr_build_pos]
#macro sxr_build_next sxr_build_tks[sxr_build_pos++]

var flags = argument0;
var tk = sxr_build_next;
var i, n, f, s, v;
switch (tk[0]) {
	case sxr_tk_undefined: sxr_build_out = [sxr_node_undefined, tk[1]]; break;
	case sxr_tk_number: sxr_build_out = [sxr_node_number, tk[1], tk[2]]; break;
	case sxr_tk_string: sxr_build_out = [sxr_node_string, tk[1], tk[2]]; break;
	case sxr_tk_ident: sxr_build_out = [sxr_node_ident, tk[1], tk[2]]; break;
	case sxr_tk_par0: // (value)
		if (sxr_build_expr(0)) return true;
		tk = sxr_build_next;
		if (tk[0] != sxr_tk_par1) return sxr_build_exit("Expected a closing parenthesis.", tk);
		break;
	case sxr_tk_unop: // !value, ~value
		if (sxr_build_expr(sxr_build_no_ops)) return true;
		if (sxr_build_out[0] == sxr_node_number) {
			f = sxr_build_out[2];
			switch (tk[2]) {
				case sxr_unop_bit: f = ~f; break;
				case sxr_unop_dec: f = -f; break;
				case sxr_unop_log: f = !f; break;
			}
			sxr_build_out[@2] = f;
		} else sxr_build_out = [sxr_node_unop, tk[1], tk[2], sxr_build_out];
		break;
	case sxr_tk_binop:
		switch (tk[2]) {
			case sxr_op_add: // +value
				if (sxr_build_expr(sxr_build_no_ops)) return true;
				break;
			case sxr_op_sub: // -value
				if (sxr_build_expr(sxr_build_no_ops)) return true;
				if (sxr_build_out[0] != sxr_node_number) {
					sxr_build_out = [sxr_node_unop, tk[1], sxr_unop_dec, sxr_build_out];
				} else sxr_build_out[@2] *= -1;
				break;
			default: return sxr_build_exit("Unexpected token", tk);
		}
		break;
	default: return sxr_build_exit("Unexpected token", tk);
}
//
if (sxr_build_out[0] == sxr_node_ident) {
	tk = sxr_build_curr;
	if (tk[0] != sxr_tk_par0) {
		s = sxr_build_out[2];
		v = sxr_var_map[?s];
		if (v == undefined) {
			if (ds_map_exists(sxr_const_map, s)) {
				v = sxr_const_map[?s];
				if (is_real(v) || is_int64(v) || is_bool(v)) {
					sxr_build_out[@0] = sxr_node_number;
					sxr_build_out[@2] = v;
				} else if (is_string(v)) {
					sxr_build_out[@0] = sxr_node_string;
					sxr_build_out[@2] = v;
				} else if (is_undefined(v)) {
					sxr_build_out = [sxr_node_undefined, sxr_build_out[1]];
				} else return sxr_build_exit("Constant type ("
					+ typeof(v) + ") for " + s + " is not supported", sxr_build_out);
			} else if (script_exists(sxr_var_func)) {
				sxr_build_out[@0] = sxr_node_var;
				sxr_build_out[@2] = sxr_var_func;
				sxr_build_out[@3] = s;
			} else return sxr_build_exit(s + " is not a known constant/variable", sxr_build_out);
		} else {
			sxr_build_out[@0] = sxr_node_var;
			sxr_build_out[@2] = v;
			sxr_build_out[@3] = s;
		}
	}
}
//
while (1) {
	tk = sxr_build_next;
	switch (tk[0]) {
		case sxr_tk_par0: // value(...)
			if (sxr_build_call(tk)) return true;
			continue;
		case sxr_tk_binop: // value + value
			if (sxr_build_ops(tk)) return true;
			continue;
		default: sxr_build_pos--; // ->
	}
	break;
}
return false;