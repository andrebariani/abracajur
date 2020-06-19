extends Area2D

<<<<<<< HEAD
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
=======
var invincibility_active = false setget set_invincibility

signal invincibility_started
signal invincibility_ended

func set_invincibility(v):
	invincibility_active = v
	if invincibility_active:
		emit_signal("invincibility_started")
		
	else:
		emit_signal("invincibility_ended")


func start_invincibility(d):
	self.invincibility_active = true
	$Iframes.start(d)


func _on_Iframes_timeout():
	self.invincibility_active = false


func _on_Hurtbox_invincibility_started():
	$CollisionShape2D.set_deferred("disabled", true)
	


func _on_Hurtbox_invincibility_ended():
	$CollisionShape2D.disabled = false
	print_debug("inv off.")
>>>>>>> bariani
