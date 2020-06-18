extends Control


func _ready():
	for node in self.get_children():
		node.hide()
	$StartScreen.show()

func show_end_screen():
	$GameUI.hide()
	$EndScreen.show()


func _on_Start_pressed():
	$StartScreen.hide()
	$GameUI.show()


func _on_Restart_pressed():
	$EndScreen.hide()
	$GameUI.show()


func _on_MainMenu_pressed():
	$EndScreen.hide()
	$CreditsScreen.hide()
	$StartScreen.show()


func _on_GANHAR_O_JOGO_pressed():
	show_end_screen()


func _on_Credits_pressed():
	$StartScreen.hide()
	$CreditsScreen.show()
