extends Control

onready var tooltip = $Tooltip
onready var tooltipAnim = $TooltipAnim

func update_hp(_new):
	var notches = $Box/HealthScore.get_children()
	
	for i in len(notches):
		if i >= _new:
			notches[i].visible = false
		else:
			notches[i].visible = true

func _on_MagicSystem_cast_spell(spell, letter, position):
	get_node("Box/Spells/Spell" + letter).setup(spell)
	tooltip.set_text(spell["NAME"])
	tooltipAnim.play("start")


func _on_MagicSystem_reset_spells():
	for spell in $Box/Spells.get_children():
		spell.reset()


func _on_Endgame_started_cutscene(end):
	visible = false


func _on_Player_updated_health(_new):
	update_hp(_new)
