extends Area2D

var target = null

func can_see():
	return target != null

func _on_AggroBox_body_entered(body):
	if can_see():
		return
	target = body
	target.connect("activated_illusion", get_parent(), "get_diverted")
	$CollisionShape2D.self_modulate = Color(1, 1, 1, 0.5)


func _on_AggroBox_body_exited(_body):
	target = null
	$CollisionShape2D.self_modulate = Color(1, 1, 1, 0.1)
