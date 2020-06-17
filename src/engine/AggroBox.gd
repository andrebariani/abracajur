extends Area2D

var target = null


func can_see():
	return target != null

func _on_AggroBox_body_entered(body):
	target = body


func _on_AggroBox_body_exited(_body):
	target = null
