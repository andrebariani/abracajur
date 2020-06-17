extends KinematicBody2D

const INVICIBILITY = 0.5

onready var pointer = $Pointer
onready var rayCast = $RayCast2D
onready var anim = $LampAnim
onready var hurtbox = $Hurtbox
onready var HP = MAX_HP

export var MAX_HP = 4
export (int) var cooldownTeleport = 0.1

var can_teleport = true



func _process(_delta):
	var look_vec = get_global_mouse_position() - global_position
	pointer.rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("ui_select") and can_teleport:
		rayCast.cast_to = look_vec
		rayCast.force_raycast_update()
		if !rayCast.is_colliding():
			teleport()

func teleport():
	anim.play("teleport")
	global_position = get_global_mouse_position()
	can_teleport = false
	yield(get_tree().create_timer(cooldownTeleport),"timeout")
	can_teleport = true
	

func _on_Hurtbox_area_entered(area):
	HP += area.DAMAGE
	hurtbox.start_invicibility(INVICIBILITY)
	anim.play("flash")
	if HP <= 0:
		death()

func death():
	queue_free()
