/// @arg node
/// @arg buffer
/// @arg parentheses
var q = argument0, b = argument1, z = argument2;
switch (q[0]) {
	case sxr_node_undefined: buffer_write(b, buffer_text, "undefined"); break;
	case sxr_node_number: buffer_write(b, buffer_text, sxr_string_format(q[2])); break;
	case sxr_node_string:
		buffer_write(b, buffer_u8, ord("\""));
		buffer_write(b, buffer_text, q[2]);
		buffer_write(b, buffer_u8, ord("\""));
		break;
	case sxr_node_var: buffer_write(b, buffer_text, q[3]); break;
	case sxr_node_unop:
		switch (q[2]) {
			case sxr_unop_bit: buffer_write(b, buffer_u8, ord("~")); break;
			case sxr_unop_log: buffer_write(b, buffer_u8, ord("!")); break;
			case sxr_unop_dec: buffer_write(b, buffer_u8, ord("-")); break;
		}
		sxr_print_expr(q[3], b, 1);
		break;
	case sxr_node_binop:
		if (z) buffer_write(b, buffer_u8, ord("("));
		sxr_print_expr(q[3], b, 1);
		switch (q[2]) {
			case sxr_op_add: buffer_write(b, buffer_text, " + "); break;
			case sxr_op_sub: buffer_write(b, buffer_text, " - "); break;
			case sxr_op_mul: buffer_write(b, buffer_text, " * "); break;
			case sxr_op_div: buffer_write(b, buffer_text, " / "); break;
			case sxr_op_mod: buffer_write(b, buffer_text, " % "); break;
			case sxr_op_idiv: buffer_write(b, buffer_text, " div "); break;
			case sxr_op_shl: buffer_write(b, buffer_text, " << "); break;
			case sxr_op_shr: buffer_write(b, buffer_text, " >> "); break;
			case sxr_op_and: buffer_write(b, buffer_text, " & "); break;
			case sxr_op_or: buffer_write(b, buffer_text, " | "); break;
			case sxr_op_xor: buffer_write(b, buffer_text, " ^ "); break;
			case sxr_op_eq: buffer_write(b, buffer_text, " == "); break;
			case sxr_op_ne: buffer_write(b, buffer_text, " != "); break;
			case sxr_op_lt: buffer_write(b, buffer_text, " < "); break;
			case sxr_op_gt: buffer_write(b, buffer_text, " > "); break;
			case sxr_op_le: buffer_write(b, buffer_text, " <= "); break;
			case sxr_op_ge: buffer_write(b, buffer_text, " >= "); break;
			case sxr_op_band: buffer_write(b, buffer_text, " && "); break;
			case sxr_op_bor: buffer_write(b, buffer_text, " || "); break;
			default: buffer_write(b, buffer_text, " ? "); break;
		}
		sxr_print_expr(q[4], b, 1);
		if (z) buffer_write(b, buffer_u8, ord(")"));
		break;
	case sxr_node_call:
		var w = q[3];
		var n = array_length_1d(w);
		buffer_write(b, buffer_text, q[4]);
		buffer_write(b, buffer_u8, ord("("));
		for (var i = 0; i < n; i++) {
			if (i > 0) buffer_write(b, buffer_u16, ord(",") | (ord(" ") << 8));
			sxr_print_expr(w[i], b, 0);
		}
		buffer_write(b, buffer_u8, ord(")"));
		break;
	default: buffer_write(b, buffer_text, "?" + string(q));
}