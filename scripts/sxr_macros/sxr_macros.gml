//
#macro sxr_tk_eof 0
#macro sxr_tk_undefined 10
#macro sxr_tk_number 11 // (:number)
#macro sxr_tk_string 12 // (:string)
#macro sxr_tk_ident 13 // (ident:string)
#macro sxr_tk_comma 21
#macro sxr_tk_par0 23
#macro sxr_tk_par1 24
#macro sxr_tk_period 30
#macro sxr_tk_unop 31 // (:sxr_unop)
#macro sxr_tk_binop 32 // (:sxr_op)

// unary operators
#macro sxr_unop_dec 1 // -
#macro sxr_unop_log 2 // !
#macro sxr_unop_bit 3 // ~

// binary operators (priority in higher hex digit)
#macro sxr_op_mul  0x01
#macro sxr_op_div  0x02
#macro sxr_op_mod  0x03
#macro sxr_op_idiv 0x04
#macro sxr_op_add  0x10
#macro sxr_op_sub  0x11
#macro sxr_op_shl  0x20
#macro sxr_op_shr  0x21
#macro sxr_op_or   0x30
#macro sxr_op_and  0x31
#macro sxr_op_xor  0x32
#macro sxr_op_eq   0x40
#macro sxr_op_ne   0x41
#macro sxr_op_lt   0x42
#macro sxr_op_le   0x43
#macro sxr_op_gt   0x44
#macro sxr_op_ge   0x45
#macro sxr_op_band 0x50
#macro sxr_op_bor  0x60

// AST nodes
#macro sxr_node_undefined 1
#macro sxr_node_number    2 // (:number)
#macro sxr_node_string    3 // (:string)
#macro sxr_node_ident     4 // (:name)
#macro sxr_node_unop      5 // (:unop, :node)
#macro sxr_node_binop     6 // (:binop, :node, :node)
#macro sxr_node_call      7 // (:script, ...args, name:string, static:bool)
#macro sxr_node_var       8 // (:script, name:string)

// Interpreter nodes
#macro sxr_act_eof       0
#macro sxr_act_undefined 1
#macro sxr_act_number    2 // (:number)
#macro sxr_act_string    3 // (:string)
#macro sxr_act_unop      4 // (:unop)
#macro sxr_act_binop     5 // (:binop)
#macro sxr_act_add       6
#macro sxr_act_call      7 // (:script, argc:int)
#macro sxr_act_var       8 // (:script, name:string)