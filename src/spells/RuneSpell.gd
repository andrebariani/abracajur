extends "res://src/spells/Spell.gd"

var active = false
export(PackedScene) var explosion

func _ready():
	$Hurtbox/CollisionShape2D.disabled = true

func _on_AnimationPlayer_animation_finished(anim_name):
	active = true
	$Hurtbox/CollisionShape2D.disabled = false


func _on_Hurtbox_body_entered(body):
	if !active:
		return
	
	print_debug("Rune detected enemy!")
	
	_spawn(explosion)
	queue_free()
