extends KinematicBody2D

export (int) var CoolDownTP = 3
var can_TP = true

func _process(_delta):
	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_just_pressed("ui_cancel") and can_TP:
		position = get_global_mouse_position()
		can_TP = false
		yield(get_tree().create_timer(CoolDownTP),"timeout")
		can_TP = true
		
