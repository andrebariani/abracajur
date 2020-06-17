extends "res://src/enemies/Enemy.gd"

enum {
	WANDER
	CHASE
}

onready var AggroBox = $AggroBox
var state = WANDER

func _ready():
	pass # Replace with function body.



func _process(delta):
	match state:
		WANDER:
			seek_player()
		CHASE:
			var player = AggroBox.target
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				MoveDirection = MoveDirection.move_toward(direction * speed, 100 * speed)
	MoveDirection = move_and_slide(MoveDirection)
	print(state)
func seek_player():
	if AggroBox.can_see():
		state = CHASE
