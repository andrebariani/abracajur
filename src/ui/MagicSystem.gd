extends Node

export(Dictionary) var effects_scrolls = {
	"damage": [
		{ "NAME":" DE FOGO", "TYPE": "DAMAGE"}
	], 
	"disabler": [
		{ "NAME":" DE RAIO", "TYPE": "STUN"}, 
		{ "NAME":" DE VENTO", "TYPE": "KNOCKBACK"},
	], 
	"debuff": [
		{ "NAME":" DE GELO", "TYPE":"GREASE"},
		{ "NAME":" DA CORRUPÇÃO", "TYPE":"BREAK"},
	], 
	"defensive": [
		{ "NAME":" DE CURA", "TYPE":"HEAL"},
		{ "NAME": " DE PEDRA", "TYPE":"SHIELD"},
	]
}

var shape_scrolls = [
	{ 
		"NAME":"MÍSSEIS", 
		"SCENE":preload("res://src/spells/SparkSpell.tscn"), 
		"ICON": null,
		"EFFECTS": {
			"DAMAGE": 2,
			"STUN": 1,
			"KNOCKBACK": 50,
			"GREASE": 2,
			"BREAK": 2,
		}
	},
	{ 
		"NAME":"EXPLOSÃO", 
		"SCENE":preload("res://src/spells/AOESpell.tscn"), 
		"ICON": null,
		"EFFECTS": {
			"DAMAGE": 2,
			"STUN": 1,
			"KNOCKBACK": 50,
			"GREASE": 2,
			"BREAK": 2,
			"HEAL": 1,
			"SHIELD": 2
		}
	},
]


# ---------------------

# parametros de signal reset_spells: nada nada nada, nada
# parametros de signal cast_spell: (packed_scene do spell, letra do spell, posicao do spell na tela)

# ---------------------


var keys = [KEY_Q, KEY_W, KEY_E, KEY_R]

# key da magia: magia
# e.g: KEY_Q: spells[0]

var active_spells = {}
export var spells_at_a_time = 4

export var max_scroll_count = 10
onready var scroll_count = max_scroll_count

signal reset_spells
signal cast_spell

func _ready():
	randomize()
	reset_spells()

func _input(event):
	if event is InputEventKey and event.pressed:
		var keycode = event.scancode
		
		if keycode in active_spells.keys():
			cast_spell(keycode)


func cast_spell(keycode):
	emit_signal("cast_spell", active_spells[keycode], OS.get_scancode_string(keycode), 
				keys.find(keycode))
	
	# Desce a quantidade de casts disponiveis
	scroll_count -= 1
	if scroll_count < 0: # Reseta tudo
		scroll_count = max_scroll_count
		reset_spells()


func reset_spells():
	active_spells.clear()
	emit_signal("reset_spells")
	var key_position = -1
		
	keys.shuffle()
	for k in len(keys):
		
	# generate a new random spell
		# generate an effect based on the given category
		var spell_category = effects_scrolls[effects_scrolls.keys()[k]]
		var rand_effect = spell_category[randi() % len(spell_category)]
		
		# erase all unavailable shapes
		var available_shapes = shape_scrolls.duplicate()
		
		for shape in shape_scrolls:
			if not rand_effect["TYPE"] in shape["EFFECTS"].keys():
				available_shapes.erase(shape)
		
		# generate a shape
		var rand_shape = available_shapes[randi() % len(available_shapes)].duplicate(true)
		
		for effect in rand_shape["EFFECTS"].keys():
			if effect != rand_effect["TYPE"]:
				rand_shape["EFFECTS"].erase(effect)
		
		rand_shape["NAME"] += rand_effect["NAME"]
		active_spells[keys[k]] = rand_shape
		
		print_debug(str(k) + ": " + OS.get_scancode_string(keys[k]) + ", " + rand_shape["NAME"])
		

func random_from_dict(dict):
	return dict[dict.keys()[randi() % len(dict)]]
