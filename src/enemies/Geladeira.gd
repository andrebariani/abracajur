extends "res://src/enemies/Enemy.gd"

enum {
	WANDER
	CHASE
}

onready var AggroBox = $AggroBox
onready var rayCast = $RayCast2D
onready var moveDebug = $MoveDebug
var state = WANDER


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION)
	knockback = move_and_slide(knockback)
	
	match state:
		WANDER:
			seek_player()
			MoveDirection = MoveDirection.move_toward(Vector2.ZERO,FRICTION * delta)
		CHASE:
			var player = AggroBox.target
			if player != null:
				var direction = player.global_position - global_position
				rayCast.cast_to = direction
				rayCast.force_raycast_update()
				if !rayCast.is_colliding():
					MoveDirection = MoveDirection.move_toward(direction.normalized() * MAX_SPEED, delta * ACCELERATION)
				else:
					state = WANDER
			else:
				state = WANDER
				
	MoveDirection = move_and_slide(MoveDirection)
		
	moveDebug.set_text(str(MoveDirection))



func seek_player():
	if AggroBox.can_see():
		state = CHASE
