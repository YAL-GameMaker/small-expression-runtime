/// @arg program
var pg = argument0;
var s = pg[3];
if (s == undefined) return "(debug parameter not enabled)"
if (!is_string(s)) {
	var b = sxr_parse_charb;
	buffer_seek(b, buffer_seek_start, 0);
	sxr_print_expr(pg[3], b, 0);
	buffer_write(b, buffer_u8, 0);
	buffer_seek(b, buffer_seek_start, 0);
	s = buffer_read(b, buffer_string);
	pg[@3] = s;
}
return s;