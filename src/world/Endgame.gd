extends Area2D

var textos = ["Abajur.", "Você chegou.", 
"Em todos meus éons neste universo, poucos foram os que me impressionaram.",
"Você, abajur, foi um deles.", 
"Mesmo antes de atravessar um castelo cheio de perigos, amaldiçoado e confuso...",
 "...você foi um indíviduo notável.",
 "A sua forma e sua mente - eu posso trazê-los de volta.",
"Depois de tudo que passou... Depois de tudo que fez...",
"Acredito que mereça saber quem você realmente é."]

var active = false
var current_text = 0
var current_scene = 0

signal started_cutscene

func _process(delta):
	if Input.is_action_just_pressed("ui_select") and active:
		match current_scene:
			0:
				current_text += 1
				if current_text < len(textos):
					update_text(textos[current_text])
				else:
					transformation_animation()

func transformation_animation():
	$AnimationPlayer.play("whiteout")

func advance_cutscene():
	current_scene += 1

func update_text(_new):
	$CanvasLayer/Control/Label.text = _new

func _on_Endgame_body_entered(body):
	body.is_active = false
	active = true
	update_text(textos[current_text])
	$CanvasLayer/Control/Prosseguir.visible = true
	$AnimationPlayer.play("pulse")
	emit_signal("started_cutscene")
	
	
