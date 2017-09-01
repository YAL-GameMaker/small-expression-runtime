/// @arg name
/// @arg script
/// @arg argc Argument count [-1 for any]
/// @arg ?static Whether the funcion always produces same outputs given same inputs
#macro sxr_function_map global.sxr_function_map_val
sxr_function_map[?argument[0]] = [argument[1], argument[2], argument_count > 3 && argument[3]];