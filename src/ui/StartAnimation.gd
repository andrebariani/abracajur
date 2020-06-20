extends Control

func _input(event):
	if event.is_pressed():
		$AnimationPlayer.playback_speed = $AnimationPlayer.playback_speed * 1.1      
	else:
		$AnimationPlayer.playback_speed = 1
