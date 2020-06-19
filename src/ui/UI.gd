extends Control


func _on_Magic_System_cast_spell(spell, letter, position):
	get_node("HBoxContainer/Spell" + letter).text = spell["NAME"]
	get_node("HBoxContainer/Spell" + letter + "/Icon").visible = true
	get_node("HBoxContainer/Spell" + letter + "/Icon").texture = spell["ICON"]
	get_node("HBoxContainer/Spell" + letter + "/Icon").material.set_shader_param("color_base", spell["COLORS"].COLOR_BASE)
	get_node("HBoxContainer/Spell" + letter + "/Icon").material.set_shader_param("color_outline", spell["COLORS"].COLOR_OUTLINE)


func _on_Magic_System_reset_spells():
	for label in $HBoxContainer.get_children():
		label.text = "?"
		label.visible = false
