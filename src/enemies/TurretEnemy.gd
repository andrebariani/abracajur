extends "res://src/enemies/Enemy.gd"

onready var spellExit = $SpellExit
onready var launchCooldown = $LaunchCooldown
onready var laserChargeAnim = $LaserChargeAnim
onready var laserCharge = $LaserCharge
export var cooldown = 1

var player = null

var setted_effect = {
	"NAME":" DE CHOQUE",
	"TYPE": "STUN",
	"COLORS": {
		"COLOR_BASE": Color("00ffff"),
		"COLOR_OUTLINE": Color("0000ff"),
	},
}

var setted_spell = { 
	"NAME":"ESFERA", 
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

func _ready():
	$LaserCharge.material.set_shader_param("color_base", setted_effect.COLORS.COLOR_BASE)
	$LaserCharge.material.set_shader_param("color_outline", setted_effect.COLORS.COLOR_OUTLINE)


func _physics_process(_delta):
	MoveDirection = Vector2.ZERO
	state_machine()


func state_machine():
	match state:
		IDLE:
			laserChargeAnim.stop()
			seek_player()
		CHASE:
			player = AggroBox.target
			if player != null:
				var direction = player.global_position - spellExit.global_position
				rayCast.cast_to = direction
				rayCast.force_raycast_update()
				if !rayCast.is_colliding():
					if launchCooldown.get_time_left() == 0:
						if setted_spell.NAME == "RAIO":
							laserChargeAnim.play("ready_ray", 0)
						else:
							launch_spell()
							launchCooldown.start(cooldown)
				else:
					laserChargeAnim.stop()
					set_state(IDLE)
			else:
				laserChargeAnim.stop()
				set_state(IDLE)
		STUN:
			laserChargeAnim.stop()
			return


func launch_spell():
	var spell = setted_spell.SCENE.instance()
	spell.chosen_effect = setted_effect.TYPE
	spell.effects = setted_spell.EFFECTS
	spell.colors = setted_effect.COLORS
	spell._set_colors()
	spell.caster = self


	match (spell.name):
		"SphereSpell":
			spell.global_position = spellExit.global_position
			spell.init(spellExit.global_position.direction_to(player.global_position))
			spell.get_node("SpellHitbox").set_collision_mask(8)
		"RaySpell":
			spell.global_position = spellExit.global_position
			spell.player = player
			spell.duration = 0.5
			spell.get_node("SpellHitbox").set_collision_mask(8)
		"BarrageSpell":
			spell.global_position = (spellExit.global_position + 
			Vector2(spell.radius, spell.radius) * global_position.direction_to(player.global_position).normalized())
			spell.player = player
			spell.set_masker(8)
	
	var world = get_tree().current_scene
	world.add_child(spell)



func _on_Hurtbox_area_entered(area):
	if not has_shield:
		var spell = area.spell
		match spell.chosen_effect:
			"DAMAGE":
				apply_damage(spell.effects)
			"STUN":
				apply_stun(spell.effects)
			"BREAK":
				apply_break(spell)
			"ILLUSION":
				apply_illusion(spell.effects, spell.caster)
			"HEAL":
				apply_heal(spell)
			"SHIELD":
				apply_shield(spell.effects)
				
	hurtbox.start_invincibility(0.1)


func _on_LaserChargeAnim_animation_finished(anim_name):
	if anim_name == "ready_ray":
		launch_spell()
		launchCooldown.start(cooldown)
