extends Control


func _on_MagicSystem_cast_spell(spell, letter, position):
	get_node("HBoxContainer/Spell" + letter).setup(spell)


func _on_MagicSystem_reset_spells():
	for spell in $HBoxContainer.get_children():
		spell.set_text("?")
