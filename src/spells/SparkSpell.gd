extends "res://src/spells/Spell.gd"

var speed = 100

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

func init(direction: Vector2, speed: int = self.speed):
	self.direction = direction
	self.speed = speed
	set_colors()


func set_colors():
	$Sprite.material.set_shader_param("color_base", color_base)
	$Sprite.material.set_shader_param("color_outline", color_outline)



func _physics_process(delta):
	velocity = speed * direction
	var collision = move_and_collide(velocity*delta)
	if collision:
		queue_free()


func _on_Hitbox_area_entered(area):
	queue_free()
