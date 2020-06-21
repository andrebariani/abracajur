extends Control

signal started_game

func _ready():
	for node in range(1, len(self.get_children())):
		self.get_children()[node].hide()
	$StartScreen.show()
	DJ.play_after_fade_out("LevelTheme")

func show_end_screen():
	$GameUI.hide()
	$EndScreen.show()


func _on_Start_pressed():
	$StartScreen.hide()
	$Background.hide()
	emit_signal("started_game")

func _on_Restart_pressed():
	$EndScreen.hide()
	$GameUI.show()


func _on_MainMenu_pressed():
	$EndScreen.hide()
	$CreditsScreen.hide()
	$StartScreen.show()
	$Background.show()


func _on_GANHAR_O_JOGO_pressed():
	show_end_screen()


func _on_Credits_pressed():
	$StartScreen.hide()
	$CreditsScreen.show()
