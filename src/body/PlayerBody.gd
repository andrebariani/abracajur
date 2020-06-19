extends Node2D

func _input(event):
	if event is InputEventMouseMotion:
	   _move_eyes(event.position)

func _move_eyes(pos : Vector2):
	var rect = get_viewport_rect().size
	pos = (pos - (rect/2))/rect
	$Body/Head/Eyes.position = pos * Vector2(4,2)
	
