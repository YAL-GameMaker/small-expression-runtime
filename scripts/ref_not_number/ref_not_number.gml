/// @desc Checks if a value is a number and returns an error to SXR if it isn't.
/// @arg value
/// @arg context
var v = argument0;
if (is_real(v) || is_int64(v) || is_bool(v)) return false;
var q = argument1;
if (!is_string(q)) q = "argument " + string(q);
sxr_exec_error = "Expected a number for " + q
	+ ", got " + string(v) + " (" + typeof(v) + ")";
return true;