extends Node

export(Dictionary) var effects_scrolls = {
	"damage": [
		{ 
			"NAME":" DE FOGO", 
			"TYPE": "DAMAGE",
			"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c")
			}
		}
	], 
	"disabler": [
		{ 
			"NAME":" DE RAIO",
			"TYPE": "STUN",
			"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c")
			}
		}, 
		{ 
			"NAME":" DE VENTO"
			 "TYPE": "KNOCKBACK",
			 "COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c")
			}
	], 
	"debuff": [
		{ 
			"NAME":" DE GELO",
			"TYPE":"GREASE",
			"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c")
			}
		{ 
			"NAME":" DA CORRUPÇÃO",
			"TYPE":"BREAK",
			"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c")
			}
	], 
	"defensive": [
		{ 
			"NAME":" DE CURA",
			"TYPE":"HEAL",
			"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c")
			}
		{ 
			"NAME": " DE PEDRA",
			"TYPE":"SHIELD",
			"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c")
			}
	],
}

	"disabler": [
		{ 
			"NAME":" DE RAIO",
			"TYPE": "STUN", "COLOR":Color(0, 0, 1, 1)}, 
		{ 
			"NAME":" DE VENTO",
			"TYPE": "KNOCKBACK", "COLOR":Color(0, 93.0/255.0, 0, 1)},
	], 
	"debuff": [
		{ 
			"NAME":" DE GELO",
			"TYPE":"GREASE", "COLOR":Color(0, 1, 1, 1)},
		{ 
			"NAME":" DA CORRUPÇÃO",
			"TYPE":"BREAK", "COLOR":Color(151.0/255.0, 0, 1, 1)},
	], 
	"defensive": [
		{ 
			"NAME":" DE CURA",
			"TYPE":"HEAL", "COLOR":Color(1, 0, 155.0/255.0, 1)},
		{ 
			"NAME": " DE PEDRA",
			"TYPE":"SHIELD", "COLOR":Color(1, 1, 1, 1)},
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
			"KNOCKBACK": 500,
			"GREASE": 175,
			"BREAK": 1,
			"HEAL": 1,
			"SHIELD": 2
		},
		"CHOSEN_EFFECT": "",
		"COLOR_BASE": Color(0,0,0,0),
		"COLOR_OUTLINE": Color(0,0,0,0)
	},
	#{ 
	#	"NAME":"EXPLOSÃO", 
	#	"SCENE":preload("res://src/spells/AOESpell.tscn"), 
	#	"ICON": null,
	#	"EFFECTS": {
	#		"DAMAGE": 3,
	#		"STUN": 1,
	#		"KNOCKBACK": 1000,
	#		"GREASE": 175,
	#		"BREAK": 2,
	#		"HEAL": 2,
	#		"SHIELD": 2
	#	},
	#	"CHOSEN_EFFECT": "",
	#	"COLOR_BASE": Color(0,0,0,0),
	#	"COLOR_OUTLINE": Color(0,0,0,0)
	#},
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
		
		rand_shape.CHOSEN_EFFECT = rand_effect.TYPE
		rand_shape.COLOR_BASE = rand_effect.COLOR_BASE
		rand_shape.COLOR_OUTLINE = rand_effect.COLOR_OUTLINE
		
		rand_shape["NAME"] += rand_effect["NAME"]
		active_spells[keys[k]] = rand_shape
		
		print_debug(str(k) + ": " + OS.get_scancode_string(keys[k]) + ", " + rand_shape["NAME"])
	

func random_from_dict(dict):
	return dict[dict.keys()[randi() % len(dict)]]
