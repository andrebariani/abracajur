extends "res://src/spells/Spell.gd"

var active = false
var explosion = preload("res://src/spells/AOESpell.gd")

func _ready():
	$Hurtbox/CollisionShape2D.disabled = true

func _on_AnimationPlayer_animation_finished(anim_name):
	active = true
	$Hurtbox/CollisionShape2D.disabled = false

func _on_Hurtbox_area_entered(area):
	if !active:
		return
	
	var spell = explosion.instance()
	spell.position = position
	spell.effects = effects
	spell.chosen_effect = chosen_effect
	spell.colors = colors
	spell._set_colors()
