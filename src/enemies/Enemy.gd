extends KinematicBody2D

export var max_hp = 3
export var speed = 30
onready var hp = max_hp
var MoveDirection = Vector2.ZERO

func _on_Hurtbox_area_entered(area):
	var spell = area.spell
	hp += spell.DAMAGE
	print_debug(hp)
