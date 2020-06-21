extends "res://src/enemies/Enemy.gd"

export var enemy_body = ""

func set_state(new_state):
	.set_state(new_state)
	
	if !is_instance_valid(find_node(enemy_body)):
		return
	
	if new_state == STUN or new_state == IDLE:
		find_node(enemy_body).stop()
	elif new_state == CHASE:
		find_node(enemy_body).resume()
