extends "res://src/spells/Spell.gd"

var MAX_LENGTH = 2000

onready var player
onready var uncle_ray = $RayCast2D
onready var beam = $Sprite
onready var end = $End
var from_player = true

var endpoint

export var duration = 1
var clock = 0

func _physics_process(delta):
	clock += delta
	
	if clock > duration:
		queue_free()
	print_debug(player)
	if is_instance_valid(player):
		self.call_deferred("launch")
	else:
		queue_free()
	


func launch():
	var look_vector
	if player == caster:
		look_vector = player.look_vector
		var total_radius = player.get_total_radius(0)
		self.position = player.global_position + Vector2(total_radius, total_radius) * look_vector.normalized()
		var max_cast_to = look_vector.normalized() * MAX_LENGTH
		uncle_ray.cast_to = max_cast_to

	else:
		look_vector = global_position.direction_to(player.global_position)
		var max_cast_to = look_vector.normalized() * MAX_LENGTH
		uncle_ray.cast_to = max_cast_to
		
	if uncle_ray.is_colliding() and look_vector:
		end.global_position = uncle_ray.get_collision_point()
		$SpellHitbox.rotation = atan2(look_vector.y, look_vector.x)
		$SpellHitbox.position = (end.global_position - self.global_position + ($Begin.position - end.position)/2)
		$SpellHitbox/CollisionShape2D.get_shape().extents = Vector2(end.position.length()/2, 8)
	else:
		end.global_position = uncle_ray.cast_to
	
	beam.rotation = uncle_ray.cast_to.angle()
	beam.region_rect.end.x = end.position.length()

