extends "res://src/spells/Spell.gd"


func _process(_delta):
	position = get_global_mouse_position()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
