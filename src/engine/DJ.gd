extends Node

signal current_changed(name)

onready var songs_list = $songs
onready var fadeOutTween = $FadeOutTween

var songs = { }

# Current stream playing
var current: AudioStreamPlayer
# Auxiliary stream to play, used for fade effects and vertical mixing
var next: AudioStreamPlayer

func _ready():
	for s in songs_list.get_children():
		songs[str(s.name)] = s


func stop():
	current.stop()


func play(name: String, from: float = 0.0):
	fadeOutTween.stop_all()
	
	if songs[name]:
		if next: next.stop()
		next = songs[name]
		
		# Do not start the same song again
		if current && next.name == current.name: return
		if current: current.stop()
		
		current = next
		
		emit_signal("current_changed", current.name)
		current.play(from)
	else:
		print_debug("Song \'" + name + "\' not found")


func play_after_fade_out(name: String, duration: float = 0.0):
	fadeOutTween.stop_all()
	
	if songs[name]:
		next = songs[name]
		
		if current && next.name == current.name: return
		
		fadeOutTween.interpolate_method(current, "set_volume_db",
			current.get_volume_db(), -80, duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
		fadeOutTween.start()
	else:
		print_debug("Song \'" + name + "\' not found")


func _on_FadeOutTween_tween_completed(object, _key):
	object.stop()
	object.set_volume_db(0)
	
	current = next
	emit_signal("current_changed", current.name)
	current.play()
