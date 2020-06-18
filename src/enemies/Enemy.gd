extends KinematicBody2D

enum {
	WANDER
	CHASE
	STUN
}

onready var AggroBox = $AggroBox
onready var rayCast = $RayCast2D
var state = WANDER

const FRICTION = 200
const ACCELERATION = 200

export var max_hp = 3
export var MAX_SPEED = 50
onready var hp = max_hp
var MoveDirection = Vector2.ZERO

func _physics_process(delta):
	state_machine(delta)
	MoveDirection = move_and_slide(MoveDirection)

func state_machine(delta):
	match state:
		WANDER:
			seek_player()
			MoveDirection = MoveDirection.move_toward(Vector2.ZERO,FRICTION * delta)
		CHASE:
			var player = AggroBox.target
			if player != null:
				var direction = player.global_position - global_position
				rayCast.cast_to = direction
				rayCast.force_raycast_update()
				if !rayCast.is_colliding():
					MoveDirection = MoveDirection.move_toward(direction.normalized() * MAX_SPEED, delta * ACCELERATION)
				else:
					set_state(WANDER)
			else:
				set_state(WANDER)
		STUN:
			return

func set_state(new_state):
	state = new_state

func seek_player():
	if AggroBox.can_see():
		set_state(CHASE)

# ---- React to stimuli -------------

func take_damage(damage):
	hp += damage

func set_stun(stun):
	set_state(STUN)
	$StunTimer.start(stun)

# ---- Handle signals ----------

func _on_Hurtbox_area_entered(area):
	var spell = area.spell
	take_damage(spell.DAMAGE)
	print_debug(hp)

func _on_StunTimer_timeout():
	set_state(WANDER)
