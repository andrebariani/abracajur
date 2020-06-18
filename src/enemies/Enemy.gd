extends KinematicBody2D

export var FRICTION = 200
export var ACCELERATION = 200

export var max_hp = 3
export var MAX_SPEED = 50
onready var hp = max_hp
var MoveDirection = Vector2.ZERO
var knockback = Vector2.ZERO

var effects_types = [
	"DAMAGE",
	"STUN",
	"KNOCKBACK",
	"GREASE",
	"BREAK",
	"HEAL",
	"SHIELD"
]


func _on_Hurtbox_area_entered(area):
	var spell = area.spell
	match spell.chosen_effect:
		"DAMAGE":
			apply_damage(spell.effects)
		"STUN":
			apply_stun(spell.effects)
		"KNOCKBACK":
			apply_knockback(area)
		"GREASE":
			apply_grease(spell.effects)
		"BREAK":
			apply_break(spell.effects)
		"HEAL":
			apply_heal(spell.effects)
		"SHIELD":
			apply_shield(spell.effects)
	
	
	
func apply_damage(spell_effects):
	hp = clamp(hp - spell_effects.DAMAGE, 0, max_hp)
	print_debug("damage! " + str(hp))


func apply_heal(spell_effects):
	hp = clamp(hp + spell_effects.HEAL, 0, max_hp)
	print_debug("heal! " + str(hp))


func apply_stun(spell_effects):
	hp += spell_effects.DAMAGE
	print_debug(hp)
	

func apply_knockback(area):
	var knockback_direction = area.global_position.direction_to(self.global_position)
	knockback = area.spell.effects.KNOCKBACK * knockback_direction.normalized()
	print(str(knockback))


func apply_grease(spell_effects):
	ACCELERATION -= spell_effects.GREASE
	FRICTION = 1
	
	
func apply_break(spell_effects):
	max_hp = max(max_hp - spell_effects.BREAK, 1)
	print_debug("HP reduced to " + str(max_hp))
	

func apply_shield(spell_effects):
	hp += spell_effects.DAMAGE
	print_debug(hp)
