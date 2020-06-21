extends Control

var started_game = false
signal started_game

func _ready():
	for node in range(1, len(self.get_children()) - 1):
		self.get_children()[node].hide()
	$StartScreen.show()
	
	if DJ.is_music_playing():
		DJ.play_after_fade_out("LevelTheme")
	else:
		DJ.play("LevelTheme")

func _process(_delta):
	if Input.is_action_just_pressed("ui_select") and !started_game:
		_on_Start_pressed()

func show_end_screen():
	$GameUI.hide()
	$EndScreen.show()


func _on_Start_pressed():
	$StartScreen.hide()
	$Background.hide()
	$Start.play()
	started_game = true
	emit_signal("started_game")

func _on_Restart_pressed():
	$EndScreen.hide()
	$GameUI.show()


func _on_MainMenu_pressed():
	$StartScreen/AnimationPlayer.play("Nova Animação")
	$EndScreen.hide()
	$CreditsScreen.hide()
	$StartScreen.show()
	$Background.show()


func _on_GANHAR_O_JOGO_pressed():
	show_end_screen()


func _on_Credits_pressed():
	$StartScreen.hide()
	$CreditsScreen.show()
