/// @arg first
// You can also use https://en.wikipedia.org/wiki/Shunting-yard_algorithm
var nodes = ds_list_create();
ds_list_add(nodes, sxr_build_out);
//
var ops = ds_list_create();
ds_list_add(ops, argument0);
//
var tk, i, n, k;
while (1) {
	if (sxr_build_expr(sxr_build_no_ops)) {
		ds_list_destroy(nodes);
		ds_list_destroy(ops);
		return true;
	}
	ds_list_add(nodes, sxr_build_out);
	tk = sxr_build_curr;
	if (tk[0] == sxr_tk_binop) {
		sxr_build_pos++;
		ds_list_add(ops, tk);
	} else break;
}
// Find the priority range:
var pmin = 7, pmax = 0;
n = ds_list_size(ops);
for (i = 0; i < n; i++) {
	tk = ops[|i];
	var pcur = tk[2] >> 4;
	if (pcur < pmin) pmin = pcur;
	if (pcur > pmax) pmax = pcur;
}
// Nest operators from top to bottom priority:
while (pmin <= pmax) {
	for (i = 0; i < n; i++) {
		tk = ops[|i];
		if ((tk[2] >> 4) != pmin) continue;
		nodes[|i] = [sxr_node_binop, tk[1], tk[2], nodes[|i], nodes[|i + 1]];
		ds_list_delete(nodes, i + 1);
		ds_list_delete(ops, i);
		n -= 1; i -= 1;
	}
	pmin += 1;
}
// Cleanup and return:
sxr_build_out = nodes[|0];
ds_list_destroy(nodes);
ds_list_destroy(ops);
return false;