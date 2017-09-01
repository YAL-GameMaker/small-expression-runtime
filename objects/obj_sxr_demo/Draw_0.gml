draw_set_font(fnt_test);
draw_set_color(c_white);
var s;
if (program != undefined) {
	s = sxr_exec(program);
	if (is_string(s)) {
		s = "\"" + s + "\"";
	} else if (is_real(s) || is_int64(s) || is_bool(s)) {
		s = sxr_string_format(s)
	} else s = string(s);
} else s = error;
draw_text_ext(4, 4, "See ref_init for setting up."
	+ "\nType an expression and press Enter."
	+ "\nInput: " + keyboard_string
	+ "\nSeen as: " + text
	+ "\nOutput: " + s,
	-1, room_width - 8);
if (keyboard_check_pressed(vk_enter)) {
	program = sxr_compile(keyboard_string, 1);
	if (program != undefined) {
		text = sxr_print(program);
	} else {
		text = "<error>";
		error = sxr_compile_error;
	}
}