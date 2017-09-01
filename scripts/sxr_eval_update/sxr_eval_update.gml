/// @desc Checks cached snippets and deletes ones that weren't used for long enough.
#macro sxr_eval_update_time global.sxr_eval_update_time_val
#macro sxr_eval_update_rate global.sxr_eval_update_rate_val
//
var t = current_time;
sxr_eval_update_time = t;
t -= sxr_eval_cache_time;
//
var l = sxr_eval_cache_list;
var m = sxr_eval_cache_map;
var i = ds_list_size(l);
while (--i >= 0) {
	var q = l[|i];
	if (q[1] <= t) {
		ds_list_delete(l, i);
		ds_map_delete(m, q[0]);
		q = undefined;
	}
}