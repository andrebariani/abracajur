extends "res://src/Entity.gd"

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
onready var or_damage = damage

var healParticles = preload("res://src/engine/HealParticles.tscn")
var corruptionParticles = preload("res://src/engine/CorruptionParticles.tscn")

onready var AggroBox = $AggroBox
onready var rayCast = $RayCast2D
onready var moveDebug = $MoveDebug
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision

enum {
	IDLE
	CHASE
	STUN
}

var state = IDLE

var MoveDirection = Vector2.ZERO
var knockback = Vector2.ZERO
var vulnerable = false
var targeted = false
var stun_interval = 0.0
var stun_clock = 0.0

var color = Color(1, 1, 1, 1)
export(Material) var blink_material

export(Vector2) var extents

var original_target

func _ready():
	$CollisionShape2D.get_shape().extents = extents
	$EnemyHitbox/CollisionShape2D.get_shape().extents = extents
	$Hurtbox/CollisionShape2D.get_shape().extents = extents
	$SoftCollision/CollisionShape2D.get_shape().extents = extents

func _physics_process(delta):
	state_machine()
	if knockback != Vector2.ZERO:
		knockback = knockback.move_toward(Vector2.ZERO, FRICTION)
		knockback = move_and_slide(knockback)
	else:
		if softCollision.is_colliding():
			MoveDirection += softCollision.get_push_vector() * delta * 800
		MoveDirection = move_and_slide(MoveDirection)
	moveDebug.set_text(str(MoveDirection) + str(state))
	
	if !$StunTimer.paused:
		stun_clock += delta
		if stun_clock > stun_interval:
			stun_clock = 0
			if $StunIcon.frame >= $StunIcon.hframes-1:
				$StunIcon.frame = 0
			else:
				$StunIcon.frame += 1

func state_machine():
	match state:
		IDLE:
			seek_player()
			MoveDirection = MoveDirection.move_toward(Vector2.ZERO,FRICTION)
		CHASE:
			var player = AggroBox.target
			if is_instance_valid(player):
				var direction = player.global_position - global_position
				rayCast.cast_to = direction
				rayCast.force_raycast_update()
				if !rayCast.is_colliding():
					MoveDirection = MoveDirection.move_toward(direction.normalized() * MAX_SPEED, 
															ACCELERATION)
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

func set_color(_new):
	color = _new
	set_modulate(color)

# ---- Handle signals ----------

func _on_Hurtbox_area_entered(area):
	var spell = area.spell
	if not has_shield:
		match spell.chosen_effect:
			"DAMAGE":
				apply_damage(spell.effects)
				hurtbox.start_invincibility(spell.inv_frames)
			"STUN":
				apply_stun(spell.effects)
			"KNOCKBACK":
				apply_knockback(area)
			"GREASE":
				apply_grease(spell.effects)
			"BREAK":
				apply_break(spell)
			"ILLUSION":
				apply_illusion(spell.effects, spell.caster)
				hurtbox.start_invincibility(spell.inv_frames)
			"HEAL":
				apply_heal(spell)
			"SHIELD":
				apply_shield(spell.effects)
				
	
	
func create_effect(scene, spell_colors):
	var s = scene.instance()
	s.color = spell_colors.COLOR_BASE
	add_child(s)
	
# ---- React to stimuli -------------

func apply_damage(spell_effects):
	DJ.play_sfx("Damage")
	var damager = spell_effects.DAMAGE
	if vulnerable:
		damager *= 10
		print_debug("SO MUCH DAMAGE")
	
	hp = clamp(hp - damager, 0, max_hp)
	if hp == 0:
		die()
	print_debug("damage: " + str(damager) + ", HP:  " + str(hp))
	
	self.material = blink_material
	$BlinkTimer.start(0.2)
	hurtbox.start_invincibility(0.1)


func apply_heal(spell):
	hp = clamp(hp + spell.effects.HEAL, 0, max_hp)
	create_effect(healParticles, spell.colors)


func apply_stun(spell_effects):
	set_state(STUN)
	$StunTimer.start(spell_effects.STUN)
	$StunIcon.visible = true
	$StunIcon.frame = 0
	stun_interval = float(spell_effects.STUN)/float($StunIcon.hframes)
	print_debug("Stunned for " + str(spell_effects.STUN) + " seconds!")
	

func apply_knockback(area):
	var knockback_direction = area.global_position.direction_to(self.global_position)
	knockback = area.spell.effects.KNOCKBACK * knockback_direction.normalized()


func apply_grease(spell_effects):
	if spell_effects.GREASE == 0:
		return
	
	$GreaseTimer.start(spell_effects.GREASE)
	FRICTION = 0
	ACCELERATION = 0
	set_color(Color(0, 1, 1, 1))
	
	
func apply_break(spell):
	set_vulnerable(true)
	$BreakTimer.start(spell.effects.BREAK)
	damage = clamp(damage - 1, 0, damage)
	
	print_debug("Vulnerable for " + str(spell.effects.BREAK) + " seconds")
	create_effect(corruptionParticles, spell.colors)

func set_vulnerable(_new):
	if vulnerable == _new:
		return
	
	vulnerable = _new
	if _new == true:
		scale *= 0.5
	else:
		scale *= 2

func apply_illusion(spell_effects, caster):
	if is_instance_valid(caster) and caster.has_method("activate_illusion"):
		caster.activate_illusion(self, spell_effects.ILLUSION)
		$IllusionTimer.start(spell_effects.ILLUSION)
		$IllusionIcon.visible = true
		$AggroBox/CollisionShape2D.scale /= 2
		MAX_SPEED /= 2
	else:
		print_debug("Invalid caster!")

func get_diverted(new_target, duration):
	if new_target != self and AggroBox.target != null:
		if original_target == null:
			original_target = AggroBox.target
		$DivertedTimer.start(duration)
		AggroBox.target = new_target

# ------ Timer durations ----------------

func _on_StunTimer_timeout():
	set_state(IDLE)
	$StunIcon.visible = false

func _on_GreaseTimer_timeout():
	ACCELERATION = 200
	FRICTION = 200
	set_color(Color(1, 1, 1, 1))

func _on_BreakTimer_timeout():
	set_vulnerable(false)
	damage = or_damage

func _on_IllusionTimer_timeout():
	$IllusionIcon.visible = false
	$AggroBox/CollisionShape2D.scale *= 2
	MAX_SPEED *= 2

func _on_DivertedTimer_timeout():
	AggroBox.target = original_target


func die():
	queue_free()


func _on_BlinkTimer_timeout():
	self.material = null

func _on_Endgame_started_cutscene(_ender):
	call_deferred("free")
