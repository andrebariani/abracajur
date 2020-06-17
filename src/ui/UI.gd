extends "res://src/ui/magic_system.gd"

func _process(delta):
	if Input.is_action_just_pressed("spell_q"):
		.cast_spells()
	elif Input.is_action_just_pressed("spell_w"):
		.cast_spells()
	elif Input.is_action_just_pressed("spell_e"):
		.cast_spells()
	elif Input.is_action_just_pressed("spell_r"):
		.cast_spells()
