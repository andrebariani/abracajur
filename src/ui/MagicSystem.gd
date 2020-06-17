extends Node

enum EFFECTS {
	DAMAGE,
	SLOW,
	STUN,
	KNOCKBACK,
	GREASE,
	BREAK,
	SHIELD
}

#var effect_scrolls = [
#	{ "NAME":"DE FOGO", "TYPE": DAMAGE, "VALUE": 0},
#	{ "NAME":"DE GOSMA", "TYPE":SLOW, "VALUE": 1}, 
#	{ "NAME":"DE RAIO", "TYPE":STUN, "VALUE": 1},
#	{ "NAME":"DE VENTO", "TYPE":KNOCKBACK, "VALUE": 1},
#	{ "NAME":"DE GELO", "TYPE":GREASE, "VALUE": 1},
#	{ "NAME":"DA CORRUPÇÃO", "TYPE":BREAK, "VALUE": 1},
#	{ "NAME":"DE CURA", "TYPE":DAMAGE, "VALUE": 1},
#	{ "NAME": "DE PEDRA", "TYPE":SHIELD, "VALUE": 1},
#]

var shape_scrolls = [
	{ 
		"NAME":"MÍSSEIS", 
		"SCENE":preload("res://src/spells/SparkSpell.tscn"), 
		"ICON": null,
		"EFFECTS": {
			"DAMAGE": 0
		}
	},
	{ 
		"NAME":"Explosivo", 
		"SCENE":preload("res://src/spells/AOESpell.tscn"), 
		"ICON": null,
		"EFFECTS": {
			"DAMAGE": 0
		}
	},
]


func create_spell(category):
	pass
	
	


# ---------------------

# parametros de signal reset_spells: nada nada nada, nada
# parametros de signal cast_spell: (packed_scene do spell, letra do spell, posicao do spell na tela)

# ---------------------


var keys = [KEY_Q, KEY_W, KEY_E, KEY_R]

export(Dictionary) var spells = {
	"damage": [
		DAMAGE
	], 
	"disabler": [
		STUN, KNOCKBACK
	], 
	"debuff": [
		GREASE, BREAK
	], 
	"defensive": [
		DAMAGE, SHIELD
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
	
	var randomized_order = range(spells_at_a_time).duplicate()
	randomized_order.shuffle()
	
	for i in randomized_order:
		# generate the next random key
		var remaining_options = len(keys) - key_position - (spells_at_a_time - i)
		var rand_key_offset = 1
		if remaining_options != 0:
			rand_key_offset = 1 + (int(rand_range(1, spells_at_a_time)) % remaining_options)
		
		key_position += rand_key_offset
		var rand_key = keys[key_position]
		
		# generate a new random spell
		var spell_category = spells[spells.keys()[i]]
		var rand_spell = spell_category[randi() % len(spell_category)]
		while rand_spell in active_spells.values():
			rand_spell = spell_category [randi() % len(spell_category)]
		
		active_spells[rand_key] = rand_spell
		
		print_debug(str(i) + ": " + OS.get_scancode_string(rand_key) + ", " + rand_spell.SPELL_NAME)
		
	keys.shuffle()
	for k in keys:
		
		
