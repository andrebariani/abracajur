extends Node2D


func get_node_position(name):
	var target_node = get_node(name)
	if target_node:
		return get_node(name).get_index()
	else:
		print_debug(":D ERROR: node doesn't ecziste!")
		return null
