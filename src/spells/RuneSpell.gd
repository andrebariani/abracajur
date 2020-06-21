extends "res://src/spells/Spell.gd"

var active = false
export(PackedScene) var explosion

func _ready():
	$Hurtbox/CollisionShape2D.disabled = true

func _on_AnimationPlayer_animation_finished(_anim_name):
	active = true
	$Hurtbox/CollisionShape2D.disabled = false


func _on_Hurtbox_body_entered(_body):
	if !active:
		return
	
	call_deferred("_spawn", explosion, true)
	call_deferred("free")
