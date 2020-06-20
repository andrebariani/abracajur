extends "res://src/spells/ProjectileSpell.gd"

export(PackedScene) var explosion #= preload("res://src/spells/AOESpell.tscn")

func _on_Hitbox_area_entered(area):
	call_deferred("_spawn", explosion, true)
	._on_Hitbox_area_entered(area)
