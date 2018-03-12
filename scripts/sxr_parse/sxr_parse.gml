/// @arg text
#macro sxr_parse_error global.sxr_parse_error_val
#macro sxr_parse_fastb global.sxr_parse_fastb_val
#macro sxr_parse_charb global.sxr_parse_charb_val
#macro sxr_parse_tklist global.sxr_parse_tklist_val
//
var b = sxr_parse_fastb;
var sb = sxr_parse_charb;
buffer_seek(sb, buffer_seek_start, 0);
buffer_write(sb, buffer_text, argument0);
//
var n = buffer_tell(sb), p;
if (buffer_get_size(b) < n) buffer_resize(b, n);
buffer_copy(sb, 0, n, b, 0);
//
var r = sxr_parse_tklist;
ds_list_clear(r);
sxr_parse_error = "";
//
var s;
p = 0;
while (p < n) {
	var tp = p; // token position
	var c = buffer_peek(b, p++, buffer_u8);
	switch (c) {
	    case ord(" "): case ord("\t"): case ord("\r"): case ord("\n"):
	        // no action is required for whitespace
	        break;
		case ord("!"): // `!` (unary), `!=` (binary)
			if (buffer_peek(b, p, buffer_u8) == ord("=")) {
				p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_ne]);
			} else ds_list_add(r, [sxr_tk_unop, tp, sxr_unop_log]);
			break;
		case ord("~"): // `~` (unary)
			ds_list_add(r, [sxr_tk_unop, tp, sxr_unop_bit]);
			break;
		case ord("<"): // `<`, `<=`, `<<`, `<>` (`!=` alias)
			switch (buffer_peek(b, p, buffer_u8)) {
				case ord("="): p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_le]); break;
				case ord("<"): p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_shl]); break;
				case ord(">"): p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_ne]); break;
				default: ds_list_add(r, [sxr_tk_binop, tp, sxr_op_lt]);
			}; break;
		case ord(">"): // `>`, `>=`, `>>`
			switch (buffer_peek(b, p, buffer_u8)) {
				case ord("="): p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_ge]); break;
				case ord(">"): p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_shr]); break;
				default: ds_list_add(r, [sxr_tk_binop, tp, sxr_op_gt]);
			}; break;
		case ord("="): // `=`, `==`
			if (buffer_peek(b, p, buffer_u8) == ord("=")) {
				p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_eq]);
			} else ds_list_add(r, [sxr_tk_binop, tp, sxr_op_eq]);
			break;
		case ord("^"): // `^`, `^^` (`!=` alias)
			if (buffer_peek(b, p, buffer_u8) == ord("^")) {
				p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_ne]);
			} else ds_list_add(r, [sxr_tk_binop, tp, sxr_op_xor]);
			break;
		case ord("&"): // `&`, `&&`
			if (buffer_peek(b, p, buffer_u8) == ord("&")) {
				p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_band]);
			} else ds_list_add(r, [sxr_tk_binop, tp, sxr_op_and]);
			break;
		case ord("|"): // `|`, `||`
			if (buffer_peek(b, p, buffer_u8) == ord("|")) {
				p++; ds_list_add(r, [sxr_tk_binop, tp, sxr_op_bor]);
			} else ds_list_add(r, [sxr_tk_binop, tp, sxr_op_or]);
			break;
		case ord("+"): ds_list_add(r, [sxr_tk_binop, tp, sxr_op_add]); break;
		case ord("-"): ds_list_add(r, [sxr_tk_binop, tp, sxr_op_sub]); break;
		case ord("*"): ds_list_add(r, [sxr_tk_binop, tp, sxr_op_mul]); break;
		case ord("/"): ds_list_add(r, [sxr_tk_binop, tp, sxr_op_div]); break;
		case ord("%"): ds_list_add(r, [sxr_tk_binop, tp, sxr_op_mod]); break;
		//
		case ord("."): // `.` or `.37`
			c = buffer_peek(b, p, buffer_u8);
			if (c >= ord("0") && c <= ord("9")) {
				p++;
				while (p < n) {
					c = buffer_peek(b, p, buffer_u8);
					if (c == ord(".") || c >= ord("0") && c <= ord("9")) {
						p++;
					} else break;
				}
				ds_list_add(r, [sxr_tk_number, tp, real(sxr_parse_sub(tp, p))]);
			} else {
				sxr_parse_error = "Unexpected character at position " + string(tp);
				return undefined;
			}
			break;
		case ord(","): ds_list_add(r, [sxr_tk_comma, tp]); break;
		case ord("("): ds_list_add(r, [sxr_tk_par0, tp]); break;
		case ord(")"): ds_list_add(r, [sxr_tk_par1, tp]); break;
		case ord("\""): case ord("'"): // `"string"`, `'string'`
		    // for simplicity, we don't do escape characters here
			while (p < n) {
				if (buffer_peek(b, p, buffer_u8) != c) {
					p += 1;
				} else break;
			}
			if (p >= n) {
				sxr_parse_error = "Unclosed quote at position " + string(tp);
				return undefined;
			}
			ds_list_add(r, [sxr_tk_string, tp, sxr_parse_sub(tp + 1, p++)]);
			break;
		default:
			if (c >= ord("0") && c <= ord("9")) { // `3.37`
				while (p < n) {
					c = buffer_peek(b, p, buffer_u8);
					if (c == ord(".") || c >= ord("0") && c <= ord("9")) {
						p++;
					} else break;
				}
				ds_list_add(r, [sxr_tk_number, tp, real(sxr_parse_sub(tp, p))]); break;
			} else if (c == ord("_")
				|| c >= ord("a") && c <= ord("z")
				|| c >= ord("A") && c <= ord("Z")
			) { // `ident` / `keyword`
			    // skip over [0-9a-zA-Z_] (allowed identifier characters):
				while (p < n) {
					c = buffer_peek(b, p, buffer_u8);
					if (c == ord("_")
						|| c >= ord("a") && c <= ord("z")
						|| c >= ord("A") && c <= ord("Z")
						|| c >= ord("0") && c <= ord("9")
					) {
						p++;
					} else break;
				}
				// extract the full identifier:
				s = sxr_parse_sub(tp, p);
				switch (s) { // keywords and special values are told apart early here
					//
					case "div": ds_list_add(r, [sxr_tk_binop, tp, sxr_op_idiv]); break;
					case "mod": ds_list_add(r, [sxr_tk_binop, tp, sxr_op_mod]); break;
					case "and": ds_list_add(r, [sxr_tk_binop, tp, sxr_op_band]); break;
					case "or":  ds_list_add(r, [sxr_tk_binop, tp, sxr_op_bor]); break;
					case "xor": ds_list_add(r, [sxr_tk_binop, tp, sxr_op_ne]); break;
					//
					case "true": ds_list_add(r, [sxr_tk_number, tp, true]); break;
					case "false": ds_list_add(r, [sxr_tk_number, tp, false]); break;
					case "undefined": ds_list_add(r, [sxr_tk_undefined, tp]); break;
					case "all": ds_list_add(r, [sxr_tk_number, tp, all]); break;
					case "noone": ds_list_add(r, [sxr_tk_number, tp, noone]); break;
					//
					default: ds_list_add(r, [sxr_tk_ident, tp, s]);
				}
			} else {
				sxr_parse_error = "Unexpected character at position " + string(tp);
				return undefined;
			}
	}
}
ds_list_add(r, [sxr_tk_eof, n]);
//
n = ds_list_size(r);
var arr = array_create(n);
for (p = 0; p < n; p++) arr[p] = r[|p];
return arr;