extends "res://src/body/EnemyBody.gd"


func _ready():
	turn_left()


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
