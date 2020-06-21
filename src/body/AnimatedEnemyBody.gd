extends "res://src/body/EnemyBody.gd"

func resume():
	$AnimationPlayer.play("walk-down")

func stop():
	$AnimationPlayer.stop()
	$Sprite.rotation_degrees = 0

func turn_left():
	$Sprite.rotate(.1)


func turn_right():
	pass


func turn_up():
	pass


func turn_down():
	pass

func walk():
	pass
