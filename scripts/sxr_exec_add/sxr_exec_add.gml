var stack = argument0;
var b = ds_stack_pop(stack);
var a = ds_stack_pop(stack);
if (is_string(a)) {
	if (is_string(b)) {
		ds_stack_push(stack, a + b);
	} else return "Can't add " + a + "(string) and "
		+ string(b) + "(" + typeof(b) + ")";
} else if (is_real(a) || is_int64(a) || is_bool(a)) {
	if (is_real(b) || is_int64(b) || is_bool(b)) {
		ds_stack_push(stack, a + b);
	} else return "Can't add "
		+ string(a) + "(" + typeof(a) + ") and "
		+ string(b) + "(" + typeof(b) + ")";
} else return "Can't add "
	+ string(a) + "(" + typeof(a) + ") and "
	+ string(b) + "(" + typeof(b) + ")";
//
return "";