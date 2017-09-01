var n = argument_count;
if (n == 0) return 0;
var r = 0;
for (var i = 0; i < n; i++) {
	var v = argument[i];
	if (ref_not_number(v, i)) exit;
	r += argument[i];
}
return r / n;