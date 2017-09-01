var n = argument_count;
if (n == 0) return 0;
var h = n / 2, i;
for (i = 0; i < n; i++) {
	if (ref_not_number(argument[i], i)) exit;
}
for (i = 0; i < n; i++) {
    var vi = argument[i];
    var i0 = 0, i1 = 0;
    for (var k = 0; k < n; k++) {
        var vk = argument[k];
        if (vk < vi) i0++;
        if (vk <= vi) i1++;
    }
    if (i0 < h && i1 >= h) return vi;
}
return 0;