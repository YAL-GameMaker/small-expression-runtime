/// @arg code
/// @arg ?debug Whether to keep debug information for sxr_print
// Compiles a snippet of code to a VM program.
// If an error occurs, sets sxr_compile_error and returns undefined.
#macro sxr_compile_error global.sxr_compile_error_val
#macro sxr_compile_list  global.sxr_compile_list_val
var code = argument[0];
var debug = argument_count > 1 && argument[1];
//
var tks = sxr_parse(code);
if (tks == undefined) {
	sxr_compile_error = sxr_parse_error;
	return undefined;
}
//
var q = sxr_build(tks);
if (q == undefined) {
	sxr_compile_error = sxr_build_error;
	return undefined;
}
if (sxr_optimize_expr(q)) return undefined;
//
var r = sxr_compile_list;
ds_list_clear(r);
if (sxr_compile_expr(q, r)) return undefined;
//
var n = ds_list_size(r);
var w = array_create(n);
for (var i = 0; i < n; i++) w[i] = r[|i];
if (!debug) q = undefined;
return [code, 0, w, q];