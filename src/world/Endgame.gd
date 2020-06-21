extends Area2D

var textos = ["Abajur.", "Você chegou.", 
"Em todos meus éons neste universo, poucos foram os que me impressionaram.",
"Você, abajur, foi um deles.", 
"Mesmo antes de atravessar um castelo cheio de perigos, amaldiçoado e confuso...",
 "...você foi um indíviduo notável.",
 "A sua forma e sua mente - eu posso trazê-los de volta.",
"Depois de tudo que passou... Depois de tudo que fez...",
"Acredito que mereça saber quem você realmente é."]

var revelation_textos = [[
	"Você é Isamos, filho dos seres do fogo e corajoso líder dos magos.",
	"No último momento da batalha, você teve a coragem de fazer o que outros não ousariam.",
	"Bem-vindo de volta."
],
[
	"Você é Barion, mestre das tempestades e estudioso pesquisador dos magos.",
	"No último momento da batalha, você se lembrou das palavras secretas e demonstrou grande conhecimento.",
	"Bem-vindo de volta."
],
[
	"Você é Dobneros, bruxo dos feitiços secretos e perspicaz estrategista dos magos.",
	"No último momento da batalha, você inverteu um feitiço de Cadabro e derrotou seu antigo mestre.",
	"Bem-vindo de volta."
],
[
	"Você é Garret, invocador das artes divinas e sábio mentor dos magos.",
	"No último momento da batalha, você se sacrificou pelo bem de todos e salvou o reino da destruição.",
	"Bem-vindo de volta."
],
[
	"Você é ABRAÃO CADABRO, Grão-Bruxo perverso e mestre de todas as artes.",
	"No último momento da batalha, você destruiu todos os magos com seu mais terrível poder, e sofreu as consequências de seus atos.",
	"Bem-volta, Abraão. Nem os antigos podem te parar."
]]

var active = false
var current_text = 0
var current_scene = 0
var revelation = 0

signal started_cutscene

func set_revelation(categories_used, time):
	if time < 120:
		revelation = 5
	else:
		var maxer = 0
		for i in len(categories_used):
			if categories_used[i] >= maxer:
				revelation = i

func _process(delta):
	if Input.is_action_just_pressed("ui_select") and active:
		match current_scene:
			0:
				current_text += 1
				if current_text < len(textos):
					update_text(textos[current_text])
				else:
					transformation_animation()
					current_text = 0
			2:
				current_text += 1
				if current_text < len(revelation_textos[revelation]):
					update_text(revelation_textos[revelation][current_text])
				else:
					play_credits()
					current_text = 0

func transformation_animation():
	$AnimationPlayer.play("whiteout")

func play_credits():
	pass

func advance_cutscene():
	current_scene += 1

func update_text(_new):
	$CanvasLayer/Control/Label.text = _new

func _on_Endgame_body_entered(body):
	visible = true
	$CanvasLayer/Control.visible = true
	
	body.is_active = false
	
	active = true
	update_text(textos[current_text])
	$AnimationPlayer.play("pulse")
	emit_signal("started_cutscene", self)
	
	
