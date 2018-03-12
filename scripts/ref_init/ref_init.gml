sxr_init();
// for functions you specify the script and number of arguments:
sxr_func_add("abs", ref_abs, 1, true);
sxr_func_add("sign", ref_sign, 1, true);
sxr_func_add("floor", ref_floor, 1, true);
sxr_func_add("ceil", ref_ceil, 1, true);
sxr_func_add("round", ref_round, 1, true);
//
sxr_func_add("sqrt", ref_sqrt, 1, true);
sxr_func_add("power", ref_power, 2, true);
// if function can take any number of arguments, use -1:
sxr_func_add("min", ref_min, -1, true);
sxr_func_add("max", ref_max, -1, true);
sxr_func_add("mean", ref_mean, -1, true);
sxr_func_add("median", ref_median, -1, true);
//
sxr_func_add("sin", ref_sin, 1, true);
sxr_func_add("cos", ref_cos, 1, true);
sxr_func_add("tan", ref_tan, 1, true);
// for constants you just give the value:
sxr_const_add("pi", pi);
// for variables you give a script that returns the value:
sxr_var_add("current_time", ref_current_time);
sxr_func_add("random", ref_random, 1);
sxr_var_func = ref_var_func;
