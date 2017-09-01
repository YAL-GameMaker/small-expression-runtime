/// @arg stack
/// @arg unop
var stack = argument0;
var a = ds_stack_pop(stack);
if (is_real(a) || is_int64(a) || is_bool(a)) switch (argument1) {
	case sxr_unop_bit: a = ~a; break;
	case sxr_unop_log: a = !a; break;
	case sxr_unop_dec: a = -a; break;
} else return "Expected a number, got " + string(a) + "(" + typeof(a) + ")";
ds_stack_push(stack, a);