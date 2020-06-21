extends "res://src/spells/Spell.gd"

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
