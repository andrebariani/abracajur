extends "res://src/spells/Spell.gd"


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
