extends "res://src/spells/Spell.gd"

export(PackedScene) var projectile
export var interval = 0.2
export var shots_count = 4
var player

func _ready():
	spawn_shot()

func _on_Timer_timeout():
	spawn_shot()

func spawn_shot():
	$Timer.start(interval)
	shots_count -= 1
	var inst = _spawn(projectile)
	inst.init(player.get_look_vector())
	
	if shots_count <= 0:
		queue_free()

