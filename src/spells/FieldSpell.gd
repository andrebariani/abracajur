extends "res://src/spells/Spell.gd"

func _on_Duration_timeout():
	queue_free()
