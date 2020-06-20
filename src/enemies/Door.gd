extends "res://src/enemies/TurretEnemy.gd"

func _ready():
	setted_effect = {
		"NAME":" DE CHOQUE",
		"TYPE": "STUN",
		"COLORS": {
			"COLOR_BASE": Color("00ffff"),
			"COLOR_OUTLINE": Color("0000ff"),
		},
	}

	setted_spell = { 
		"NAME":"ESFERA", 
		"SCENE":preload("res://src/spells/SphereSpell.tscn"), 
		"ICON": null,
		"EFFECTS": {
			"DAMAGE": 2,
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
