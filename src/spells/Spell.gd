extends KinematicBody2D

export var DAMAGE = -1
export var KNOCKBACK = 0
export var STUN = 0
export var BREAK = 0
export var SHIELD = 0
export(ImageTexture) var icon

# ISSO É SÓ UM PROTOTIPO PROOF-OF-CONCEPT BOBO, NÃO VAI FICAR ASSIM PROVAVELMENTE
func get_type():
	if DAMAGE > 0:
		return "DAMAGE"
	elif DAMAGE < 0:
		return "HEAL"
	elif KNOCKBACK > 0:
		return "KNOCKBACK"
	elif STUN > 0:
		return "STUN"
	elif BREAK > 0:
		return "BREAK"
	elif SHIELD > 0:
		return "SHIELD"
