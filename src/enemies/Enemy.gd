extends KinematicBody2D

const FRICTION = 200
const ACCELERATION = 200

export var max_hp = 3
export var MAX_SPEED = 50

onready var hp = max_hp
onready var hurtbox = $Hurtbox

var MoveDirection = Vector2.ZERO

func _on_Hurtbox_area_entered(area):
	var spell = area.spell
	hp += spell.DAMAGE
	hurtbox.start_invicibility(0.5)
	if hp <= 0:
		death()
		
func death():
	queue_free()
