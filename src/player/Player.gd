extends KinematicBody2D

onready var pointer = $Pointer
onready var rayCast = $RayCast2D
onready var anim = $LampAnim
onready var hurtbox = $Hurtbox/CollisionShape2D


export (int) var cooldownTeleport = 0.1


var can_teleport = true
var look_vector = Vector2.ZERO


func _process(_delta):
	look_vector = get_global_mouse_position() - global_position
	pointer.rotation = atan2(look_vector.y, look_vector.x)
	
	if Input.is_action_just_pressed("ui_select") and can_teleport:
		rayCast.cast_to = look_vector
		rayCast.force_raycast_update()
		
		anim.play("teleport")
		if !rayCast.is_colliding():
			teleport_to_mouse()
		else:
			teleport_to_nearest_wall()
			
		can_teleport = false
		yield(get_tree().create_timer(cooldownTeleport),"timeout")
		can_teleport = true


func teleport_to_mouse():
	global_position = get_global_mouse_position()
	
	
func teleport_to_nearest_wall():
	var player_radius = hurtbox.get_shape().radius
	global_position = rayCast.get_collision_point() + rayCast.get_collision_normal() * player_radius
	
	
func _on_Magic_System_cast_spell(spell_data, letter, position):
	var spell = spell_data.SCENE.instance()
	spell.effects = spell_data.EFFECTS
	spell.chosen_effect = spell_data.CHOSEN_EFFECT
	spell.colors = spell_data.COLORS
	spell._set_colors()
	
	if spell.name == "SparkSpell":
		var player_radius = hurtbox.get_shape().radius
		var spell_radius = spell.get_node("Hitbox/CollisionShape2D").get_shape().radius
		var total_radius = player_radius + spell_radius
		spell.position = global_position + Vector2(total_radius, total_radius) * look_vector.normalized()
		spell.init(look_vector.normalized())
	
	var world = get_tree().current_scene
	world.add_child(spell)
