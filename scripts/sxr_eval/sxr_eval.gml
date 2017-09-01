#macro sxr_eval_error global.sxr_eval_error_val
#macro sxr_eval_cache_map global.sxr_eval_cache_map_val
#macro sxr_eval_cache_list global.sxr_eval_cache_list_val
#macro sxr_eval_cache_time global.sxr_eval_cache_time_val
//
if (sxr_eval_update_time + sxr_eval_update_rate < current_time) sxr_eval_update();
//
var code = argument0;
var q = sxr_eval_cache_map[?code];
if (q == undefined) {
	q = sxr_compile(code);
	if (q == undefined) {
		sxr_eval_error = sxr_compile_error;
		return undefined;
	}
	sxr_eval_cache_map[?code] = q;
	ds_list_add(sxr_eval_cache_list, q);
}
//
var r = sxr_exec(q);
sxr_eval_error = sxr_exec_error;
return r;