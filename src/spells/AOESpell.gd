extends "res://src/spells/Spell.gd"

var player

func _process(_delta):
	if player:
		position = player.position

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
