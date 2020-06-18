extends KinematicBody2D

var effects = {
	"DAMAGE": 0,
	"STUN": 0,
	"KNOCKBACK": 0,
	"GREASE": 0,
	"BREAK": 0,
	"HEAL": 0,
	"SHIELD": 0
}
var chosen_effect = ""
var color_base = Color(0,0,0,0)
var color_outline = Color(0,0,0,0)


