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
var colors = {
	"COLOR_BASE": Color(0,0,0,0),
	"COLOR_OUTLINE": Color(0,0,0,0),
}

func _set_colors():
	$Sprite.material.set_shader_param("color_base", colors.COLOR_BASE)
	$Sprite.material.set_shader_param("color_outline", colors.COLOR_OUTLINE)
