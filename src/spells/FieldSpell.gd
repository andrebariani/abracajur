extends "res://src/spells/Spell.gd"

func set_particles():
	$CPUParticles2D.material.set_shader_param("color_base", colors.COLOR_BASE)
	$CPUParticles2D.material.set_shader_param("color_outline", colors.COLOR_OUTLINE)

func _on_Duration_timeout():
	queue_free()
