extends Area2D

onready var timer = $Timer 

var invincible = false setget set_invincible

signal invicibility_started
signal invicibilty_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invicibility_started")
	else:
		emit_signal("invicibilty_ended")

func start_invicibility(duration):
	self.invincible = true
	timer.start(duration)


func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invicibility_started():
	set_deferred("monitorable",false)


func _on_Hurtbox_invicibilty_ended():
	set_deferred("monitorable",true)
