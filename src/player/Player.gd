extends KinematicBody2D

onready var pointer = $Pointer
onready var rayCast = $RayCast2D
onready var anim = $LampAnim
onready var hurtbox = $Hurtbox
onready var hurtboxCollision = $Hurtbox/CollisionShape2D
onready var stunTimer = $StunTimer
onready var shieldTimer = $ShieldTimer

export (int) var cooldownTeleport = 0.1
export var max_hp = 3

onready var hp = max_hp
var can_teleport = true
var look_vector = Vector2.ZERO
var is_active = true
var has_shield = false

signal player_stunned
signal activated_illusion

func _process(_delta):
	look_vector = get_global_mouse_position() - global_position
	pointer.rotation = atan2(look_vector.y, look_vector.x)
	
	if is_active:
		if Input.is_action_just_pressed("ui_select") and can_teleport:
			rayCast.cast_to = look_vector
			rayCast.force_raycast_update()
			
			anim.play("teleport")
			if !rayCast.is_colliding():
				teleport_to_mouse()
			else:
				teleport_to_nearest_wall()
				
			can_teleport = false
			yield(get_tree().create_timer(cooldownTeleport),"timeout")
			can_teleport = true


func teleport_to_mouse():
	global_position = get_global_mouse_position()
	
	
func teleport_to_nearest_wall():
	var player_radius = hurtboxCollision.get_shape().radius
	global_position = rayCast.get_collision_point() + rayCast.get_collision_normal() * player_radius
	
	
func _on_Magic_System_cast_spell(spell_data, letter, position):
	var spell = spell_data.SCENE.instance()
	spell.effects = spell_data.EFFECTS
	spell.chosen_effect = spell_data.CHOSEN_EFFECT
	spell.colors = spell_data.COLORS
	spell._set_colors()
	spell.caster = self
	
	var show_behind = false
	
	match (spell.name):
		"SphereSpell", "MissileSpell":
			var spell_radius = spell.get_node("SpellHitbox/CollisionShape2D").get_shape().radius
			var total_radius = get_total_radius(spell_radius)
			spell.global_position = global_position + Vector2(total_radius, total_radius) * look_vector.normalized()
			spell.init(look_vector.normalized())
		"BarrageSpell":
			var spell_radius = spell.radius
			var total_radius = get_total_radius(spell_radius)
			spell.global_position = global_position + Vector2(total_radius, total_radius) * look_vector.normalized()
			spell.player = self
		"AOESpell", "RuneSpell":
			spell.position = self.position
		"EruptionSpell", "FieldSpell":
			spell.position = get_global_mouse_position()
			show_behind = true
		"RuneSpell":
			spell.position = self.position
			show_behind = true
		"RaySpell":
			spell.player = self
	
	var world = get_tree().current_scene
	world.add_child(spell)
	if show_behind:
		world.move_child(spell, world.get_node_position("Camera2D"))


func activate_illusion(new_target, duration):
	emit_signal("activated_illusion", new_target, duration)

func get_total_radius(spell_radius):
	var player_radius = hurtboxCollision.get_shape().radius
	return player_radius + spell_radius

func _on_Hurtbox_area_entered(area):
	if not has_shield:
		match area.name:
			"SpellHitbox":
				var spell = area.spell
				match spell.chosen_effect:
					"DAMAGE":
						apply_damage(spell.effects.DAMAGE)
					"STUN":
						apply_stun(spell.effects)
					"BREAK":
						apply_break(spell.effects)
					"HEAL":
						apply_heal(spell.effects.HEAL)
					"SHIELD":
						apply_shield(spell.effects)
						
				hurtbox.start_invincibility(0.1)
			"EnemyHitbox":
				var enemy = area.enemy
				apply_damage(enemy.damage)
				hurtbox.start_invincibility(1)
				
	
	
# ---- React to stimuli -------------

func apply_damage(value):
	hp = clamp(hp - value, 0, max_hp)
	if hp == 0:
		die()
	print_debug("damage! " + str(hp))


func apply_heal(value):
	hp = clamp(hp + value, 0, max_hp)
	print_debug("heal! " + str(hp))


func apply_stun(spell_effects):
	is_active = false
	emit_signal("player_stunned", is_active)
	stunTimer.start(spell_effects.STUN)

func apply_break(spell_effects):
	max_hp = max(max_hp - spell_effects.BREAK, 1)
	print_debug("HP reduced to " + str(max_hp))

func apply_shield(spell_effects):
	has_shield = true


func _on_StunTimer_timeout():
	is_active = true
	emit_signal("player_stunned", is_active)


func _on_ShieldTimer_timeout():
	has_shield = false
	print_debug("Shield is out")


func die():
	queue_free()
	
	
func get_look_vector():
	return look_vector.normalized()
