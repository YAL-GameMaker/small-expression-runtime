/// @arg tokens
#macro sxr_build_out   global.sxr_build_out_val
#macro sxr_build_pos   global.sxr_build_pos_val
#macro sxr_build_len   global.sxr_build_len_val
#macro sxr_build_tks   global.sxr_build_tks_val
#macro sxr_build_error global.sxr_build_error_val
//
var tks = argument0;
sxr_build_tks = tks;
sxr_build_len = array_length_1d(tks);
sxr_build_pos = 0;
if (sxr_build_expr(0)) {
	sxr_compile_error = "Compile error: " + sxr_build_error;
	return undefined;
} else return sxr_build_out;