extends "res://src/spells/Spell.gd"

var speed = 100

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

func init(direction: Vector2, speed: int = self.speed):
	self.direction = direction
	self.speed = speed


func _physics_process(delta):
	velocity = speed * direction
	var collision = move_and_collide(velocity*delta)
	if collision:
		queue_free()
