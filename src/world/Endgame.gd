extends Area2D

var textos = ["Abajur.", "Você chegou.", 
"Em todos meus éons neste universo, poucos foram os que me impressionaram.",
"Você, abajur, foi um deles.", 
"Mesmo antes de atravessar um castelo cheio de perigos, amaldiçoado e confuso...",
 "...você foi um indíviduo notável.",
 "A sua forma e sua mente - eu posso trazê-los de volta.",
"Depois de tudo que passou... Depois de tudo que fez...",
"Acredito que mereça saber quem você realmente é."]

var revelation_textos = [["Você é Isamos, filho dos seres do fogo e corajoso líder dos magos.",
"No último momento da batalha, você teve a coragem de fazer o que outros não ousariam.",
"Bem-vindo de volta."
],
["Você é Barion, mestre das tempestades e estudioso pesquisador dos magos.",
"No último momento da batalha, você se lembrou das palavras secretas e demonstrou grande conhecimento.",
"Bem-vindo de volta."
],
["Você é Dobneros, bruxo dos feitiços secretos e perspicaz estrategista dos magos.",
"No último momento da batalha, você inverteu um feitiço de Cadabro e derrotou seu antigo mestre.",
"Bem-vindo de volta."
],
["Você é Garret, invocador das artes divinas e sábio mentor dos magos.",
"No último momento da batalha, você se sacrificou pelo bem de todos e salvou o reino da destruição.",
"Bem-vindo de volta."
],
["Você é ABRAÃO CADABRO, Grão-Bruxo perverso e mestre de todas as artes.",
"No último momento da batalha, você destruiu todos os magos com seu mais terrível poder, e sofreu as consequências de seus atos.",
"Bem-volta, Abraão. Nem os antigos podem te parar."
]]

export var revelation_sprites = []
export(Texture) var cadabro_evil

var active = false
var current_text = 0
var current_scene = 0
var revelation = 0
var player = null

signal started_cutscene
signal play_credits

func set_revelation(categories_used, time):
	print_debug(str(time))
	
	if time < 130:
		revelation = 4
	else:
		var maxer = 0.0
		for i in len(categories_used):
			var tester = float(categories_used[i])
#			if i == 2 or i == 3:
#				tester *= 2.0/3.0
			
			if tester >= maxer:
				maxer = tester
				revelation = i
	
	print_debug("Revelation: " + str(revelation))

func _process(delta):
	if Input.is_action_just_pressed("ui_select") and active:
		match current_scene:
			0:
				current_text += 1
				if current_text < len(textos):
					update_text(textos[current_text])
				else:
					transformation_animation()
					advance_cutscene()
					current_text = -1

			2:
				current_text += 1
				if current_text == 0 and revelation == 4:
					$Mage.texture = cadabro_evil
				
				if current_text < len(revelation_textos[revelation]):
					update_text(revelation_textos[revelation][current_text])
				else:
					end_game()


func transformation_animation():
	$AnimationPlayer.play("whiteout")
	$Mage.texture = revelation_sprites[revelation]
	$Mage.global_position = player.global_position

func hide_abracajur():
	player.visible = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "whiteout":
		$AnimationPlayer.play("pulse")
		advance_cutscene()
	elif anim_name == "blackout":
		get_tree().reload_current_scene()

func end_game():
	$AnimationPlayer.play("blackout")

func advance_cutscene():
	current_scene += 1

func update_text(_new):
	$CanvasLayer/Control/Label.text = _new

func _on_Endgame_body_entered(body):
	player = body
	
	visible = true
	$CanvasLayer/Control.visible = true
	DJ.play_after_fade_out("EndTheme")
	
	player.is_active = false
	
	active = true
	update_text(textos[current_text])
	$AnimationPlayer.play("pulse")
	emit_signal("started_cutscene", self)

