extends "res://src/enemies/TurretEnemy.gd"

func _ready():
	setted_effect = {
		"NAME":" DE FOGO",
		"TYPE": "DAMAGE",
		"COLORS": {
				"COLOR_BASE": Color("bd3c30"),
				"COLOR_OUTLINE": Color("bdac2c"),
		},
	}

	setted_spell = { 
		"NAME":"RAJADA", 
		"SCENE":preload("res://src/spells/BarrageSpell.tscn"), 
		"ICON": null,
		"EFFECTS": {
			"DAMAGE": 1,
			"KNOCKBACK": 1500,
			"GREASE": 10,
			"STUN": 1,
			"BREAK": 5,
			"HEAL": 1,
			"SHIELD": 2
		},
		"CHOSEN_EFFECT": "",
		"COLORS": {
			"COLOR_BASE": Color("bd3c30"),
			"COLOR_OUTLINE": Color("bdac2c"),
		},
	}
