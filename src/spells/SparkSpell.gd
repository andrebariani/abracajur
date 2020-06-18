extends "res://src/spells/ProjectileSpell.gd"


func _on_Hitbox_area_entered(area):
	_explode()
	._on_Hitbox_area_entered(area)
	
func _explode():
	pass
