extends KinematicBody2D

onready var pointer = $Pointer
onready var rayCast = $RayCast2D
onready var anim = $LampAnim
onready var spellScene = preload("res://src/spells/LaserSpell.tscn")


export (int) var cooldownTeleport = 0.1


var can_teleport = true
var look_vector = Vector2.ZERO


func _process(_delta):
	look_vector = get_global_mouse_position() - global_position
	pointer.rotation = atan2(look_vector.y, look_vector.x)
	
	if Input.is_action_just_pressed("ui_select") and can_teleport:
		rayCast.cast_to = look_vector
		rayCast.force_raycast_update()
		if !rayCast.is_colliding():
			teleport()
			
			
	if Input.is_action_just_pressed("spell_q"):
		_on_cast_spell(spellScene)
		
	print_debug(str(look_vector))


func teleport():
	anim.play("teleport")
	global_position = get_global_mouse_position()
	can_teleport = false
	yield(get_tree().create_timer(cooldownTeleport),"timeout")
	can_teleport = true
	
	
func _on_cast_spell(spell_scene):
	pass
