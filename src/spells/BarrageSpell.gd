extends "res://src/spells/Spell.gd"

export(PackedScene) var projectile
export var interval = 0.2
export var shots_count = 4
var player
var radius = 8
var masker = 8

func _ready():
	spawn_shot()

func _on_Timer_timeout():
	spawn_shot()

func spawn_shot():
	if !is_instance_valid(player):
		return
	
	$Timer.start(interval)
	shots_count -= 1
	var inst = _spawn(projectile, false)
	
	if player == caster:
		inst.init(player.get_look_vector())
	else:
		inst.get_node("SpellHitbox").set_collision_mask(masker)
		inst.init(global_position.direction_to(player.global_position))

	inst.get_node("SpellHitbox/CollisionShape2D").get_shape().radius = radius
	
	if shots_count <= 0:
		queue_free()

func set_masker(_new):
	masker = _new
