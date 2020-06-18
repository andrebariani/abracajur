extends "res://src/spells/Spell.gd"

var active = false

func _ready():
	$Hitbox/CollisionShape2D.disabled = true

func _on_AnimationPlayer_animation_finished(anim_name):
	active = true


func _on_Hitbox_area_entered(area):
	var spell = spell_data.SCENE.instance()
	spell.effects = effects
	spell.chosen_effect = chosen_effect
	spell.colors = colors
	spell._set_colors()
