extends KinematicBody2D

var has_shield = false setget set_shield

func apply_shield(spell_effects):
	$ShieldTimer.start(spell_effects.SHIELD)
	set_shield(true)

func set_shield(_new):
	has_shield = _new
	$ShieldIcon.visible = _new

func _on_ShieldTimer_timeout():
	set_shield(false)
