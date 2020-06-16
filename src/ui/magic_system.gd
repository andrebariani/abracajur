extends Node

var keys = [KEY_Q, KEY_W, KEY_E, KEY_R, 
			KEY_A, KEY_S, KEY_D, KEY_F,
			KEY_Z, KEY_X, KEY_C, KEY_V]

var spells = ["fireball", "laser", "sword", "seilamanokk"]

# key da magia: magia
var active_spells = {KEY_Q:"fireball"}
var spells_at_a_time = 4

var scroll_count = 10
var max_scroll_count = 10

signal cast_spell

func _ready():
	reset_spells()

func _input(event):
	if event is InputEventKey and event.pressed:
		var keycode = event.scancode
		
		if keycode in active_spells.keys():
			#emit_signal("cast_spell", active_spells[keycode])
			cast_spell(active_spells[keycode])


func cast_spell(spell):
	call_deferred(spell)
	
	# Desce a quantidade de casts disponiveis
	scroll_count -= 1
	if scroll_count < 0: # Reseta tudo
		scroll_count = max_scroll_count
		reset_spells()

func reset_spells():
	active_spells.clear()
	
	for i in range(spells_at_a_time):
		# generate a new random key
		var rand_key = keys[randi() % len(keys)]
		while rand_key in active_spells.keys():
			rand_key = keys[randi() % len(keys)]
		
		# generate a new random spell
		var rand_spell = spells[randi() % len(spells)]
		while rand_spell in active_spells.values():
			rand_spell = spells[randi() % len(spells)]
		
		active_spells[rand_key] = rand_spell


# FUNCOES DOS SPELLS -------------
func fireball():
	print("fireball")
	# funcao da magia aqui

func laser():
	print("LASER VRAUUU")
	# funcao da magia aqui

