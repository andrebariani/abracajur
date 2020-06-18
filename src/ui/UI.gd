extends Control

#func _process(delta):
#	if Input.is_action_just_pressed("spell_q"):
#		.cast_spells()
#	elif Input.is_action_just_pressed("spell_w"):
#		.cast_spells()
#	elif Input.is_action_just_pressed("spell_e"):
#		.cast_spells()
#	elif Input.is_action_just_pressed("spell_r"):
#		.cast_spells()


func _on_Magic_System_cast_spell(spell, letter, position):
	get_node("HBoxContainer/Spell" + letter).text = spell["NAME"]
	get_node("HBoxContainer/Spell" + letter + "/Icon").visible = true
	get_node("HBoxContainer/Spell" + letter + "/Icon").texture = spell["ICON"]
	get_node("HBoxContainer/Spell" + letter + "/Icon").set_modulate(get_color_by_type(spell["EFFECTS"].keys()[0]))

func get_color_by_type(type):
	match type:
		"DAMAGE":
			return Color(1, 0, 0, 1)
		"HEAL":
			return Color(1, 0, 155.0/255.0, 1)
		"KNOCKBACK":
			return Color(0, 93.0/255.0, 0, 1)
		"SLOW":
			return Color(0, 207.0/255.0, 0, 1)
		"GREASE":
			return Color(0, 1, 1, 1)
		"STUN":
			return Color(0, 0, 1, 1)
		"BREAK":
			return Color(151.0/255.0, 0, 1, 1)
		"SHIELD":
			return Color(1, 1, 1, 1)
	return Color(1, 1, 1, 1)

func _on_Magic_System_reset_spells():
	for label in $HBoxContainer.get_children():
		label.text = ""
		label.visible = false
	
