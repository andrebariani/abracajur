extends "res://src/spells/Spell.gd"

var speed = 200

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
export var steer_force = 2000

func init(direction: Vector2, speed: int = self.speed):
	self.direction = direction
	self.speed = speed


func _physics_process(delta):
	var desired = (get_global_mouse_position() - position).normalized() * speed
	var steer = (desired - velocity).normalized() * steer_force
	acceleration += steer
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		queue_free()


func _on_SpellHitbox_area_entered(area):
	queue_free()


func start(_transform, _speed):
	add_to_group("enemies")
	global_transform = _transform
	speed = _speed
	velocity = transform.x * speed


