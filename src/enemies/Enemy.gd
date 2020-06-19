extends KinematicBody2D

var effects_types = [
	"DAMAGE",
	"STUN",
	"KNOCKBACK",
	"GREASE",
	"BREAK",
	"HEAL",
	"SHIELD"
]

export var FRICTION = 200
export var ACCELERATION = 200
export var MAX_SPEED = 50

export var max_hp = 3
onready var hp = max_hp

export var damage = 1


onready var AggroBox = $AggroBox
onready var rayCast = $RayCast2D
onready var moveDebug = $MoveDebug
onready var shieldTimer = $ShieldTimer
onready var hurtbox = $Hurtbox

enum {
	IDLE
	CHASE
	STUN
}

var state = IDLE

var MoveDirection = Vector2.ZERO
var knockback = Vector2.ZERO
var has_shield = false setget set_shield

func set_shield(value):
	has_shield = value


func _physics_process(delta):
	state_machine()
	if knockback != Vector2.ZERO:
		knockback = knockback.move_toward(Vector2.ZERO, FRICTION)
		knockback = move_and_slide(knockback)
	else:
		MoveDirection = move_and_slide(MoveDirection)
	moveDebug.set_text(str(MoveDirection) + str(state))


func state_machine():
	match state:
		IDLE:
			seek_player()
			MoveDirection = MoveDirection.move_toward(Vector2.ZERO,FRICTION)
		CHASE:
			var player = AggroBox.target
			if player != null:
				var direction = player.global_position - global_position
				rayCast.cast_to = direction
				rayCast.force_raycast_update()
				if !rayCast.is_colliding():
					MoveDirection = MoveDirection.move_toward(direction.normalized() * MAX_SPEED, ACCELERATION)
				else:
					set_state(IDLE)
			else:
				set_state(IDLE)
		STUN:
			MoveDirection = MoveDirection.move_toward(Vector2.ZERO,FRICTION)
			return

func set_state(new_state):
	if new_state != state:
		state = new_state

func seek_player():
	if AggroBox.can_see():
		set_state(CHASE)


# ---- Handle signals ----------

func _on_Hurtbox_area_entered(area):
	if not has_shield:
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
				
	hurtbox.start_invincibility(0.1)
	
# ---- React to stimuli -------------

func apply_damage(spell_effects):
	hp = clamp(hp - spell_effects.DAMAGE, 0, max_hp)
	if hp == 0:
		die()
	print_debug("damage! " + str(hp))
	hurtbox.start_invincibility(0.1)


func apply_heal(spell_effects):
	hp = clamp(hp + spell_effects.HEAL, 0, max_hp)
	print_debug("heal! " + str(hp))


func apply_stun(spell_effects):
	set_state(STUN)
	$StunTimer.start(spell_effects.STUN)
	print_debug("ouch!")
	

func apply_knockback(area):
	var knockback_direction = area.global_position.direction_to(self.global_position)
	knockback = area.spell.effects.KNOCKBACK * knockback_direction.normalized()


func apply_grease(spell_effects):
	ACCELERATION -= spell_effects.GREASE
	FRICTION = 1
	
	
func apply_break(spell_effects):
	max_hp = max(max_hp - spell_effects.BREAK, 1)
	print_debug("HP reduced to " + str(max_hp))
	

func apply_shield(spell_effects):
	has_shield = true
	shieldTimer.start(spell_effects.SHIELD)
	print_debug("Shield is on!")


func _on_StunTimer_timeout():
	set_state(IDLE)


func _on_ShieldTimer_timeout():
	has_shield = false
	print_debug("Shield is out")


func die():
	queue_free()
