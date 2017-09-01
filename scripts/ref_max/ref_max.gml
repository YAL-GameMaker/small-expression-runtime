var n = argument_count;
if (n == 0) return 0;
var r = argument[0];
if (ref_not_number(r, 0)) exit;
for (var i = 1; i < n; i++) {
	var v = argument[i];
	if (ref_not_number(v, i)) exit;
	if (v > r) r = v;
}
return r;