extends Control

onready var tooltip = $Tooltip
onready var tooltipAnim = $TooltipAnim

func _on_MagicSystem_cast_spell(spell, letter, position):
	get_node("HBoxContainer/Spell" + letter).setup(spell)
	tooltip.set_text(spell["NAME"])
	tooltipAnim.play("start")


func _on_MagicSystem_reset_spells():
	for spell in $HBoxContainer.get_children():
		spell.set_text("?")
