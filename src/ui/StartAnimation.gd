extends Control

func _ready():
	DJ.play("IntroCutscene")

func _input(event):
	if event.is_pressed():
		$AnimationPlayer.playback_speed = $AnimationPlayer.playback_speed * 1.1      
	else:
		$AnimationPlayer.playback_speed = 1


func _on_AnimationPlayer_animation_finished(_anim_name):
	get_tree().change_scene("res://src/world/World.tscn")
