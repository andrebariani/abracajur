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
	get_node("HBoxContainer/Spell" + letter + "/Icon").set_modulate(spell["COLOR"])



func _on_Magic_System_reset_spells():
	for label in $HBoxContainer.get_children():
		label.text = ""
		label.visible = false
	
