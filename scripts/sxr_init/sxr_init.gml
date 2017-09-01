//
sxr_parse_fastb = buffer_create(1024, buffer_fast, 1);
sxr_parse_charb = buffer_create(1024, buffer_grow, 1);
sxr_parse_tklist = ds_list_create();
sxr_compile_list = ds_list_create();
sxr_const_map = ds_map_create();
sxr_function_map = ds_map_create();
sxr_var_map = ds_map_create();
sxr_var_func = -1;
//
sxr_eval_cache_map = ds_map_create();
sxr_eval_cache_list = ds_list_create();
sxr_eval_update_time = 0;
//
sxr_eval_cache_time = 5000;
sxr_eval_update_rate = 1000;