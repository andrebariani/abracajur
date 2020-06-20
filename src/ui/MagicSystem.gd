extends Node

export(Dictionary) var effects_scrolls = {
	"damage": [
		{ 
			"NAME":" DE FOGO", 
			"TYPE": "DAMAGE",
			"COLORS": {
				"COLOR_BASE": Color("BDAC2C"),
				"COLOR_OUTLINE": Color("BD3C30"),
			},
		}
	], 
	"disabler": [
		{ 
			"NAME":" DE CHOQUE",
			"TYPE": "STUN",
			"COLORS": {
				"COLOR_BASE": Color("3EC2CD"),
				"COLOR_OUTLINE": Color("002D69"),
			},
		}, 
		{ 
			"NAME":" DE VENTO",
			 "TYPE": "KNOCKBACK",
			 "COLORS": {
				"COLOR_BASE": Color("FEFEFF"),
				"COLOR_OUTLINE": Color("AEAEAE"),
			},
		},
	], 
	"debuff": [
		{ 
			"NAME":" DE GELO",
			"TYPE":"GREASE",
			"COLORS": {
				"COLOR_BASE": Color("3EC2CD"),
				"COLOR_OUTLINE": Color("FEFEFF"),
			},
		},
		{ 
			"NAME":" DA CORRUPÇÃO",
			"TYPE":"BREAK",
			"COLORS": {
				"COLOR_BASE": Color("3C137C"),
				"COLOR_OUTLINE": Color("000000"),
			},
		},
		
		{ 
			"NAME":" DA ILUSÃO",
			"TYPE":"ILLUSION",
			"COLORS": {
				"COLOR_BASE": Color("C03470"),
				"COLOR_OUTLINE": Color("600B62"),
			},
		},
	], 
	"defensive": [
		{ 
			"NAME":" DE CURA",
			"TYPE":"HEAL",
			"COLORS": {
				"COLOR_BASE": Color("55C753"),
				"COLOR_OUTLINE": Color("366D00"),
			},
		},
		{ 
			"NAME": " DE PEDRA",
			"TYPE":"SHIELD",
			"COLORS": {
				"COLOR_BASE": Color("342800"),
				"COLOR_OUTLINE": Color("000000"),
			},
		},
	],
}

var shape_scrolls = [
	{ 
		"NAME":"BOMBA", 
		"SCENE":preload("res://src/spells/SphereSpell.tscn"), 
		"ICON": preload("res://assets/Spells/BolaOficial.png"),
		"EFFECTS": {
			"DAMAGE": 1,
			"STUN": 2,
			"KNOCKBACK": 1000,
			"GREASE": 6,
			"ILLUSION": 4,
			"BREAK": 5,
			"HEAL": 1,
		},
		"CHOSEN_EFFECT": "",
		"INV_FRAMES": 0.5,
		"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c"),
		},
	},
	{ 
		"NAME":"EXPLOSÃO", 
		"SCENE":preload("res://src/spells/AOESpell.tscn"), 
		"ICON": preload("res://assets/Spells/Botão-Explosion.png"),
		"EFFECTS": {
			"DAMAGE": 2,
			"KNOCKBACK": 1500,
			"GREASE": 10,
			"BREAK": 6,
		},
		"CHOSEN_EFFECT": "",
		"INV_FRAMES": 0.5,
		"COLORS": {
			"COLOR_BASE": Color("bd3c30"),
			"COLOR_OUTLINE": Color("bdac2c"),
		},
	},
	
	{ 
		"NAME":"ERUPÇÃO", 
		"SCENE":preload("res://src/spells/EruptionSpell.tscn"), 
		"ICON": preload("res://assets/Spells/Botão-Erupção.Png"),
		"EFFECTS": {
			"DAMAGE": 3,
			"STUN": 4,
			"KNOCKBACK": 1500,
			"GREASE": 12,
			"BREAK": 6,
			"ILLUSION": 3,
			"HEAL": 1,
			"SHIELD": 2
		},
		"CHOSEN_EFFECT": "",
		"INV_FRAMES": 0.5,
		"COLORS": {
			"COLOR_BASE": Color("bd3c30"),
			"COLOR_OUTLINE": Color("bdac2c"),
		},
	},
	
	{ 
		"NAME":"RUNA", 
		"SCENE":preload("res://src/spells/RuneSpell.tscn"), 
		"ICON": preload("res://assets/Spells/Botão-Runa.png"),
		"EFFECTS": {
			"DAMAGE": 3,
			"STUN": 4,
			"KNOCKBACK": 1000,
			"GREASE": 12,
			"BREAK": 8,
			"ILLUSION": 5,
			"HEAL": 2,
			"SHIELD": 2
		},
		"CHOSEN_EFFECT": "",
		"INV_FRAMES": 0.1,
		"COLORS": {
			"COLOR_BASE": Color("bd3c30"),
			"COLOR_OUTLINE": Color("bdac2c"),
		},
	},
	
	{ 
		"NAME":"RAJADA", 
		"SCENE":preload("res://src/spells/BarrageSpell.tscn"), 
		"ICON": preload("res://assets/Spells/Botão-Rajada.png"),
		"EFFECTS": {
			"DAMAGE": 1,
			"STUN": 1,
			"KNOCKBACK": 500,
			"GREASE": 4,
			"BREAK": 3,
		},
		"CHOSEN_EFFECT": "",
		"INV_FRAMES": 0,
		"COLORS": {
			"COLOR_BASE": Color("bd3c30"),
			"COLOR_OUTLINE": Color("bdac2c"),
		},
	},
	{ 
		"NAME":"CAMPO", 
		"SCENE":preload("res://src/spells/FieldSpell.tscn"), 
		"ICON": preload("res://assets/Spells/Botão-Campo.png"),
		"EFFECTS": {
			"DAMAGE": 1,
			"STUN": 1,
			"KNOCKBACK": 500,
			"GREASE": 3,
			"BREAK": 1,
			"HEAL": 1,
			"SHIELD": 1
		},
		"CHOSEN_EFFECT": "",
		"INV_FRAMES": 0.5,
		"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c"),
		},
	},
	{ 
		"NAME":"MÍSSIL", 
		"SCENE":preload("res://src/spells/MissileSpell.tscn"), 
		"ICON": preload("res://assets/Spells/Botão-Null.png"),
		"EFFECTS": {
			"DAMAGE": 3,
			"STUN": 3,
			"KNOCKBACK": 1500,
			"GREASE": 12,
			"BREAK": 1,
			"ILLUSION": 5,
		},
		"CHOSEN_EFFECT": "",
		"INV_FRAMES": 0,
		"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c"),
		},
	},
	{ 
		"NAME":"RAIO", 
		"SCENE":preload("res://src/spells/RaySpell.tscn"), 
		"ICON": preload("res://assets/Spells/Laser.png"),
		"EFFECTS": {
			"DAMAGE": 1,
			"STUN": 1,
			"GREASE": 3,
			"BREAK": 2,
		},
		"CHOSEN_EFFECT": "",
		"INV_FRAMES": 0.5,
		"COLORS": {
			"COLOR_BASE": Color("bd3c30"),
			"COLOR_OUTLINE": Color("bdac2c"),
		},
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

var categories_used = [0, 0, 0, 0]
var time_passed = 0.0

signal reset_spells
signal cast_spell

func _ready():
	randomize()
	reset_spells()

func _process(delta):
	time_passed += delta

func _input(event):
	if event is InputEventKey and event.pressed:
		var keycode = event.scancode
		
		if keycode in active_spells.keys():
			cast_spell(keycode)


func cast_spell(keycode):
	emit_signal("cast_spell", active_spells[keycode], OS.get_scancode_string(keycode), 
				keys.find(keycode))

	categories_used[active_spells[keycode].CATEGORY] += 1
	
	# Desce a quantidade de casts disponiveis
	scroll_count -= 1
	if scroll_count < 0: # Reseta tudo
		scroll_count = max_scroll_count
		reset_spells()


func reset_spells():
	active_spells.clear()
	emit_signal("reset_spells")
	# warning-ignore:unused_variable
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
		rand_shape.COLORS = rand_effect.COLORS
		
		rand_shape["NAME"] += rand_effect["NAME"]
		rand_shape["CATEGORY"] = k
		active_spells[keys[k]] = rand_shape
		
		print_debug(str(k) + ": " + OS.get_scancode_string(keys[k]) + ", " + rand_shape["NAME"])
	

func random_from_dict(dict):
	return dict[dict.keys()[randi() % len(dict)]]
