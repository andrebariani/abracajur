extends Node

export var icons = []

var shape_scrolls = [
	{"NAME":"MÍSSEIS", "SCENE":preload("res://src/spells/SparkSpell.tscn"), "ICON":icons[0]}, 
]

var effect_scrolls = [
	{"NAME":"DE FOGO", "DAMAGE":1, "KNOCKBACK":0, "STUN":0, "SLOW": 0, 
	"GREASE": 0, "BREAK": 0, "SHIELD": 0}, 
	{"NAME":"DE GOSMA", "DAMAGE":0, "KNOCKBACK":0, "STUN":0, "SLOW": 1, 
	"GREASE": 0, "BREAK": 0, "SHIELD": 0}, 
	{"NAME":"DE RAIO", "DAMAGE":0, "KNOCKBACK":0, "STUN":1, "SLOW": 0, 
	"GREASE": 0, "BREAK": 0, "SHIELD": 0}, 
	{"NAME":"DE VENTO", "DAMAGE":0, "KNOCKBACK":1, "STUN":0, "SLOW": 0, 
	"GREASE": 0, "BREAK": 0, "SHIELD": 0}, 
	{"NAME":"DE GELO", "DAMAGE":1, "KNOCKBACK":0, "STUN":0, "SLOW": 0, 
	"GREASE": 0, "BREAK": 0, "SHIELD": 0}, 
	{"NAME":"DA CORRUPÇÃO", "DAMAGE":0, "KNOCKBACK":0, "STUN":0, "SLOW": 0, 
	"GREASE": 0, "BREAK": 1, "SHIELD": 0}, 
	{"NAME":"CURA", "DAMAGE":-1, "KNOCKBACK":0, "STUN":0, "SLOW": 0, 
	"GREASE": 0, "BREAK": 0, "SHIELD": 0}, 
	{"NAME":"ESCUDO", "DAMAGE":0, "KNOCKBACK":0, "STUN":0, "SLOW": 0, 
	"GREASE": 0, "BREAK": 0, "SHIELD": 1}
]

func create_spell(category):
	pass
	
	
