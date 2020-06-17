extends KinematicBody2D

export var max_hp = 3
onready var hp = max_hp

func _on_Hurtbox_area_entered(area):
	var spell = area.spell
	hp += spell.DAMAGE
	print_debug(hp)
