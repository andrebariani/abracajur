extends KinematicBody2D

const FRICTION = 200
const ACCELERATION = 200

export var max_hp = 3
export var MAX_SPEED = 50
onready var hp = max_hp
var MoveDirection = Vector2.ZERO

func _on_Hurtbox_area_entered(area):
	var spell = area.spell
	hp += spell.effects.DAMAGE
	print_debug(hp)
