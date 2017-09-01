/// @desc
/// @arg script
/// @arg stack
/// @arg argCount
var fn = argument0;
var q = argument1;
var n = argument2;
// this could really use a function to call a script with argument-array.
// also, these blocks are not handwritten, just in case you're wondering.
var v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, r;
switch (n >> 2) {
case 0: switch (n) {
	case 0:
		r = script_execute(fn);
		break;
	case 1:
		r = script_execute(fn, ds_stack_pop(q));
		break;
	case 2:
		v0 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v0);
		break;
	case 3:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v1, v0);
		break;
}; break;
case 1: switch (n) {
	case 4:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v2, v1, v0);
		break;
	case 5:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v3, v2, v1, v0);
		break;
	case 6:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v4, v3, v2, v1, v0);
		break;
	case 7:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		v5 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v5, v4, v3, v2, v1, v0);
		break;
}; break;
case 2: switch (n) {
	case 8:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		v5 = ds_stack_pop(q);
		v6 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v6, v5, v4, v3, v2, v1, v0);
		break;
	case 9:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		v5 = ds_stack_pop(q);
		v6 = ds_stack_pop(q);
		v7 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v7, v6, v5, v4, v3, v2, v1, v0);
		break;
	case 10:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		v5 = ds_stack_pop(q);
		v6 = ds_stack_pop(q);
		v7 = ds_stack_pop(q);
		v8 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v8, v7, v6, v5, v4, v3, v2, v1, v0);
		break;
	case 11:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		v5 = ds_stack_pop(q);
		v6 = ds_stack_pop(q);
		v7 = ds_stack_pop(q);
		v8 = ds_stack_pop(q);
		v9 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v9, v8, v7, v6, v5, v4, v3, v2, v1, v0);
		break;
}; break;
case 3: switch (n) {
	case 12:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		v5 = ds_stack_pop(q);
		v6 = ds_stack_pop(q);
		v7 = ds_stack_pop(q);
		v8 = ds_stack_pop(q);
		v9 = ds_stack_pop(q);
		v10 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v10, v9, v8, v7, v6, v5, v4, v3, v2, v1, v0);
		break;
	case 13:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		v5 = ds_stack_pop(q);
		v6 = ds_stack_pop(q);
		v7 = ds_stack_pop(q);
		v8 = ds_stack_pop(q);
		v9 = ds_stack_pop(q);
		v10 = ds_stack_pop(q);
		v11 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v11, v10, v9, v8, v7, v6, v5, v4, v3, v2, v1, v0);
		break;
	case 14:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		v5 = ds_stack_pop(q);
		v6 = ds_stack_pop(q);
		v7 = ds_stack_pop(q);
		v8 = ds_stack_pop(q);
		v9 = ds_stack_pop(q);
		v10 = ds_stack_pop(q);
		v11 = ds_stack_pop(q);
		v12 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v12, v11, v10, v9, v8, v7, v6, v5, v4, v3, v2, v1, v0);
		break;
	case 15:
		v0 = ds_stack_pop(q);
		v1 = ds_stack_pop(q);
		v2 = ds_stack_pop(q);
		v3 = ds_stack_pop(q);
		v4 = ds_stack_pop(q);
		v5 = ds_stack_pop(q);
		v6 = ds_stack_pop(q);
		v7 = ds_stack_pop(q);
		v8 = ds_stack_pop(q);
		v9 = ds_stack_pop(q);
		v10 = ds_stack_pop(q);
		v11 = ds_stack_pop(q);
		v12 = ds_stack_pop(q);
		v13 = ds_stack_pop(q);
		r = script_execute(fn, ds_stack_pop(q), v13, v12, v11, v10, v9, v8, v7, v6, v5, v4, v3, v2, v1, v0);
		break;
}; break;
default:
	if (n != 16) return "Too many arguments";
	v0 = ds_stack_pop(q);
	v1 = ds_stack_pop(q);
	v2 = ds_stack_pop(q);
	v3 = ds_stack_pop(q);
	v4 = ds_stack_pop(q);
	v5 = ds_stack_pop(q);
	v6 = ds_stack_pop(q);
	v7 = ds_stack_pop(q);
	v8 = ds_stack_pop(q);
	v9 = ds_stack_pop(q);
	v10 = ds_stack_pop(q);
	v11 = ds_stack_pop(q);
	v12 = ds_stack_pop(q);
	v13 = ds_stack_pop(q);
	v14 = ds_stack_pop(q);
	r = script_execute(fn, ds_stack_pop(q), v14, v13, v12, v11, v10, v9, v8, v7, v6, v5, v4, v3, v2, v1, v0);
}
ds_stack_push(q, r);
return sxr_exec_error;