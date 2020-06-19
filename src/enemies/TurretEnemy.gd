extends "res://src/enemies/Enemy.gd"

onready var spellExit = $SpellExit
onready var launchCooldown = $LaunchCooldown
export var cooldown = 1

var setted_effect = {
	"NAME":" DE FOGO", 
	"TYPE": "DAMAGE",
	"COLORS": {
		"COLOR_BASE": Color("bd3c30"),
		"COLOR_OUTLINE": Color("bdac2c"),
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

func _physics_process(delta):
	MoveDirection = Vector2.ZERO
	state_machine()
	


func state_machine():
	match state:
		IDLE:
			seek_player()
		CHASE:
			var player = AggroBox.target
			if player != null:
				var direction = player.global_position - spellExit.global_position
				rayCast.cast_to = direction
				rayCast.force_raycast_update()
				if !rayCast.is_colliding():
					if launchCooldown.get_time_left() == 0:
						launch_spell(player)
						launchCooldown.start(cooldown)
				else:
					set_state(IDLE)
			else:
				set_state(IDLE)
		STUN:
			return


func launch_spell(player):
	var spell = setted_spell.SCENE.instance()
	spell.chosen_effect = setted_effect.TYPE
	spell.effects = setted_spell.EFFECTS
	spell.colors = setted_effect.COLORS
	spell._set_colors()
	spell.caster = self

	spell.get_node("SpellHitbox").set_collision_mask(8)

	match (spell.name):
		"SphereSpell":
			spell.global_position = spellExit.global_position
			spell.init(spellExit.global_position.direction_to(player.global_position))
		"RaySpell":
			spell.global_position = spellExit.global_position
			spell.from_player = false
			spell.player = player
			spell.duration = 1
	
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
				apply_break(spell.effects)
			"ILLUSION":
				apply_illusion(spell.effects, spell.caster)
			"HEAL":
				apply_heal(spell.effects)
			"SHIELD":
				apply_shield(spell.effects)
				
	hurtbox.start_invincibility(0.1)
