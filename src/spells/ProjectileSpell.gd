extends "res://src/spells/Spell.gd"

var speed = 100

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

func init(direction: Vector2, speed: int = self.speed):
	self.direction = direction
	self.rotation = atan2(direction.y, direction.x)
	self.speed = speed


func _physics_process(delta):
	velocity = speed * direction
	var collision = move_and_collide(velocity*delta)
	if collision:
		queue_free()


func _on_Hitbox_area_entered(area):
	call_deferred("free")
