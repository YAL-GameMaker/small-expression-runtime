/// @arg first
var first = argument0;
var node = sxr_build_out;
if (node[0] != sxr_node_ident) return sxr_build_exit("Expression is not callable", first);
//
var fname = node[2];
var func = sxr_function_map[?fname];
if (func == undefined) return sxr_build_exit(node[2] + " is not a known function", node);
//
var nodes = ds_list_create();
var seenComma = true;
while (1) {
	var tk = sxr_build_curr;
	switch (tk[0]) {
		case sxr_tk_eof:
			ds_list_destroy(nodes);
			return sxr_build_exit("Unclosed parenthesis", first);
		case sxr_tk_par1: sxr_build_pos++; break; // ->
		case sxr_tk_comma:
			if (seenComma) {
				ds_list_destroy(nodes);
				return sxr_build_exit("Unexpected comma", tk);
			} else {
				seenComma = true;
				sxr_build_pos++;
				continue;
			}
		default:
			if (seenComma) {
				seenComma = false;
				if (sxr_build_expr(0)) {
					ds_list_destroy(nodes);
					return true;
				} else ds_list_add(nodes, sxr_build_out);
				continue;
			} else {
				ds_list_destroy(nodes);
				return sxr_build_exit("Expected a comma or a closing parenthesis", tk);
			}
	}
	break;
}
//
var n = ds_list_size(nodes), i;
if (func[1] != -1 && func[1] != n) {
	ds_list_destroy(nodes);
	return sxr_build_exit("Expected " + string(func[1]) + " arguments, got " + string(n), first);
}
//
var w = array_create(n);
for (i = 0; i < n; i++) w[i] = nodes[|i];
ds_list_destroy(nodes);
//
sxr_build_out = [sxr_node_call, first[1], func[0], w, fname, func[2]];
return false;