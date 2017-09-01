#macro sxr_exec_error global.sxr_exec_error_val
#macro sxr_exec_buffers global.sxr_exec_buffers_val
//
var pg = argument0;
pg[@1] = current_time;
sxr_exec_error = "";
var arr = pg[2];
var len = array_length_1d(arr);
var pos = 0;
//
var stack = ds_stack_create();
var s;
//
while (pos < len) {
	var q = arr[pos++];
	switch (q[0]) {
		case sxr_act_undefined: ds_stack_push(stack, undefined); break;
		case sxr_act_number: ds_stack_push(stack, q[2]); break;
		case sxr_act_string: ds_stack_push(stack, q[2]); break;
		case sxr_act_unop:
			s = sxr_exec_unop(stack, q[2]);
			if (s != "") return sxr_exec_exit(s, q, stack);
			break;
		case sxr_act_add:
			s = sxr_exec_add(stack);
			if (s != "") return sxr_exec_exit(s, q, stack);
			break;
		case sxr_act_binop:
			s = sxr_exec_binop(stack, q[2]);
			if (s != "") return sxr_exec_exit(s, q, stack);
			break;
		case sxr_act_call:
			s = sxr_exec_call(q[2], stack, q[3]);
			if (s != "") return sxr_exec_exit(s, q, stack);
			break;
		case sxr_act_var:
			ds_stack_push(stack, script_execute(q[2], q[3]));
			s = sxr_exec_error;
			if (s != "") return sxr_exec_exit(s, q, stack);
			break;
	}
}
//
var r = ds_stack_pop(stack);
ds_stack_destroy(stack);
return r;