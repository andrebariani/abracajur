extends Area2D

var target = null

func can_see():
	return target != null

func _on_AggroBox_body_entered(body):
	if can_see():
		return
	target = body
	
	target.get_signal_list()
	target.connect("activated_illusion", get_parent(), "get_diverted")
	$CollisionShape2D.self_modulate = Color(1, 1, 1, 0.5)


func _on_AggroBox_body_exited(_body):
	if is_instance_valid(target) and target.is_connected("activated_illusion", get_parent(), "get_diverted"):
		target.disconnect("activated_illusion", get_parent(), "get_diverted")
		target = null
	$CollisionShape2D.self_modulate = Color(1, 1, 1, 0.1)
