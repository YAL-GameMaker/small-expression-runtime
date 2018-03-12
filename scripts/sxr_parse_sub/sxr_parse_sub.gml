/// sxr_parse_sub(start, till)
/// @arg start
/// @arg end
// Extracts a substring between start-end.
var i = argument0;
var n = argument1 - i;
var sb = sxr_parse_charb;
if (buffer_get_size(sb) < n + 1) buffer_resize(sb, n + 1);
buffer_copy(sxr_parse_fastb, i, n, sb, 0);
buffer_poke(sb, n, buffer_u8, 0);
buffer_seek(sb, buffer_seek_start, 0);
return buffer_read(sb, buffer_string);