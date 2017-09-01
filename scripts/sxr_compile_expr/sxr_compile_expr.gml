/// @arg node
/// @arg out
var q = argument0;
var r = argument1;
var o, i, n, w;
//
switch (q[0]) {
	case sxr_node_undefined: ds_list_add(r, [sxr_act_undefined, q[1]]); break;
	case sxr_node_number: ds_list_add(r, [sxr_act_number, q[1], q[2]]); break;
	case sxr_node_string: ds_list_add(r, [sxr_act_string, q[1], q[2]]); break;
	case sxr_node_unop:
		if (sxr_compile_expr(q[3], r)) return true;
		ds_list_add(r, [sxr_act_unop, q[1], q[2]]);
		break;
	case sxr_node_binop:
		if (sxr_compile_expr(q[3], r)) return true;
		if (sxr_compile_expr(q[4], r)) return true;
		if (q[2] != sxr_op_add) {
			ds_list_add(r, [sxr_act_binop, q[1], q[2]]);
		} else ds_list_add(r, [sxr_act_add, q[1]]);
		break;
	case sxr_node_call:
		w = q[3];
		n = array_length_1d(w);
		for (i = 0; i < n; i++) {
			if (sxr_compile_expr(w[i], r)) return true;
		}
		ds_list_add(r, [sxr_act_call, q[1], q[2], n]);
		break;
	case sxr_node_var:
		ds_list_add(r, [sxr_act_var, q[1], q[2], q[3]]);
		break;
	default:
		sxr_compile_error = "Cannot compile type " + string(q[0])
			 + " at position " + string(q[1]);
		return true;
}
return false;