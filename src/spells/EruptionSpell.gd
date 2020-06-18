extends "res://src/spells/Spell.gd"


func _ready():
	position = get_global_mouse_position()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
