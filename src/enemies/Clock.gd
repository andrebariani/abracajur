extends "res://src/enemies/TurretEnemy.gd"

func _ready():
	setted_effect = { 
			"NAME":" DA CORRUPÇÃO",
			"TYPE":"BREAK",
			"COLORS": {
				"COLOR_BASE": Color("4e00ac"),
				"COLOR_OUTLINE": Color("1c003e"),
			},
		}

	setted_spell = { 
		"NAME":"RAIO", 
		"SCENE":preload("res://src/spells/RaySpell.tscn"),
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
