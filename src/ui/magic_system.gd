extends Node

# ---------------------

# parametros de signal reset_spells: nada nada nada, nada
# parametros de signal cast_spell: (packed_scene do spell, letra do spell, posicao do spell na tela)

# ---------------------


var keys = [KEY_Q, KEY_W, KEY_E, KEY_R, 
			KEY_A, KEY_S, KEY_D, KEY_F]

export(Dictionary) var spells = {
	"damage": [
		preload("res://src/spells/LaserSpell.tscn")
	], 
	"knockback": [
		preload("res://src/spells/LaserSpell.tscn")
	], 
	"stun/break": [
		preload("res://src/spells/LaserSpell.tscn")
	], 
	"heal/shield": [
		preload("res://src/spells/LaserSpell.tscn")
	]
}
# damage, knockback, stun/break, cura/escudo

# key da magia: magia
# e.g: KEY_Q: spells[0]

var active_spells = {}
export var spells_at_a_time = 4

export var max_scroll_count = 10
onready var scroll_count = max_scroll_count

signal reset_spells
signal cast_spell

func _ready():
	reset_spells()

func _input(event):
	if event is InputEventKey and event.just_pressed:
		var keycode = event.scancode
		
		if keycode in active_spells.keys():
			cast_spell(keycode)


func cast_spell(keycode):
	emit_signal("cast_spell", active_spells[keycode], OS.get_scancode_string(keycode), 
				active_spells.keys().find(keycode))
	
	# Desce a quantidade de casts disponiveis
	scroll_count -= 1
	if scroll_count < 0: # Reseta tudo
		scroll_count = max_scroll_count
		reset_spells()


func reset_spells():
	active_spells.clear()
	emit_signal("reset_spells")
	var key_position = -1
	
	for i in range(spells_at_a_time):
		# generate the next random key
		var remaining_options = len(keys) - key_position - (spells_at_a_time - i)
		var rand_key_offset = 1
		if remaining_options != 0:
			rand_key_offset = 1 + (int(rand_range(1, spells_at_a_time)) % remaining_options)
		
		key_position += rand_key_offset
		var rand_key = keys[key_position]
		
		# generate a new random spell
		var rand_spell = spells[int(rand_range(1, spells.size()))][randi() % len(spells[i])]
		while rand_spell in active_spells.values():
			rand_spell = spells[i][int(rand_range(1, spells.size())) % len(spells[i])]
		
		active_spells[rand_key] = rand_spell
		
		print_debug(str(i) + ": " + OS.get_scancode_string(rand_key) + ", " + rand_spell.name)
