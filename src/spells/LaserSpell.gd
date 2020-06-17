extends "res://src/spells/Spell.gd"

func _physics_process(delta):
	move_and_slide(Vector2.RIGHT * 100)
