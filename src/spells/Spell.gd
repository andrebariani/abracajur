extends KinematicBody2D

var caster = null

var inv_frames = 0

var effects = {
	"DAMAGE": 0,
	"STUN": 0,
	"KNOCKBACK": 0,
	"GREASE": 0,
	"BREAK": 0,
	"ILLUSION": 0,
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

func _spawn(spawnee):
	var spell = spawnee.instance()
	spell.effects = effects
	spell.chosen_effect = chosen_effect
	spell.colors = colors
	spell._set_colors()
	spell.position = self.position
	spell.caster = caster
	spell.inv_frames = inv_frames
	
	var world = get_tree().current_scene
	world.add_child(spell)
	
	return spell
