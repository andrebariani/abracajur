extends "res://src/Entity.gd"

onready var pointer = $Pointer
onready var rayCast = $RayCast2D
onready var anim = $LampAnim
onready var hurtbox = $Hurtbox
onready var hurtboxCollision = $Hurtbox/CollisionShape2D
onready var stunTimer = $StunTimer
onready var shieldTimer = $ShieldTimer
onready var playerBody = $PlayerBody

var healParticles = preload("res://src/engine/HealParticles.tscn")
var corruptionParticles = preload("res://src/engine/CorruptionParticles.tscn")

export (int) var cooldownTeleport = 2
export var max_hp = 10

onready var hp = max_hp
var can_teleport = true
var look_vector = Vector2.ZERO
var is_active = false
var vulnerable = false
var diverting = false
var stun_interval = 0.0
var stun_clock = 0.0

onready var hg_interval = float(cooldownTeleport)/float($Hourglass.hframes-1)
var hg_clock = 0.0

export(Material) var blink_material

signal player_stunned
signal activated_illusion
signal updated_health

func _ready():
	set_hp(max_hp)

func _process(_delta):
	look_vector = get_global_mouse_position() - global_position
	pointer.rotation = atan2(look_vector.y, look_vector.x)
	diverting = false
	
	$Hourglass.global_position = get_global_mouse_position()
	
	if is_active:
		if Input.is_action_just_pressed("ui_select") and can_teleport:
			rayCast.cast_to = look_vector
			rayCast.force_raycast_update()
			
			DJ.play("Teleport")
			anim.play("teleport")
			if !rayCast.is_colliding():
				teleport_to_mouse()
			else:
				teleport_to_nearest_wall()
				
			can_teleport = false
			$Hourglass.visible = true
			$Hourglass.frame = 0
			yield(get_tree().create_timer(cooldownTeleport),"timeout")
			DJ.play("TeleportRecharge")
			can_teleport = true
			$Hourglass.visible = false
	
	if !$StunTimer.paused:
		stun_clock += _delta
		if stun_clock > stun_interval:
			stun_clock = 0
			if $StunIcon.frame >= $StunIcon.hframes-1:
				$StunIcon.frame = 0
			else:
				$StunIcon.frame += 1
	
	if $Hourglass.visible:
		hg_clock += _delta
		if hg_clock > hg_interval:
			hg_clock = 0
			if $Hourglass.frame >= $Hourglass.hframes-1:
				$Hourglass.frame = 0
			else:
				$Hourglass.frame += 1


func teleport_to_mouse():
	global_position = get_global_mouse_position()
	
	
func teleport_to_nearest_wall():
	var player_radius = hurtboxCollision.get_shape().radius
	global_position = rayCast.get_collision_point() + rayCast.get_collision_normal() * player_radius
	
	
func _on_MagicSystem_cast_spell(spell_data, _letter, _position):
	var spell = spell_data.SCENE.instance()
	spell.effects = spell_data.EFFECTS
	spell.chosen_effect = spell_data.CHOSEN_EFFECT
	spell.colors = spell_data.COLORS
	spell._set_colors()
	spell.caster = self
	spell.inv_frames = spell_data.INV_FRAMES
	
	var show_behind = false
	
	
	match (spell.name):
		"SphereSpell":
			DJ.play("MissileLaunch")
			var spell_radius = spell.get_node("SpellHitbox/CollisionShape2D").get_shape().radius
			var total_radius = get_total_radius(spell_radius)
			spell.global_position = global_position + Vector2(total_radius, total_radius) * look_vector.normalized()
			spell.init(look_vector.normalized())
		"MissileSpell":
			var spell_radius = spell.get_node("SpellHitbox/CollisionShape2D").get_shape().radius
			var total_radius = get_total_radius(spell_radius)
			spell.global_position = global_position + Vector2(total_radius, total_radius) * look_vector.normalized()
			spell.init(look_vector.normalized())
		"BarrageSpell":
			DJ.play("BarrageSpell")
			var spell_radius = spell.radius
			var total_radius = get_total_radius(spell_radius)
			spell.global_position = global_position + Vector2(total_radius, total_radius) * look_vector.normalized()
			spell.player = self
		"AOESpell":
			spell.position = self.position
		"EruptionSpell":
			DJ.play("EruptionSpell")
			spell.position = get_global_mouse_position()
			show_behind = true
		"FieldSpell":
			DJ.play("FieldSpell")
			spell.position = get_global_mouse_position()
			show_behind = true
		"RuneSpell":
			DJ.play("RuneSpell")
			spell.position = self.position
			show_behind = true
		"RaySpell":
			DJ.play("RaySpell")
			spell.player = self
	
	var world = get_tree().current_scene
	world.add_child(spell)
	if show_behind:
		world.move_child(spell, world.get_node_position("Camera2D"))


func activate_illusion(new_target, duration):
	if !diverting:
		emit_signal("activated_illusion", new_target, duration)
		diverting = true

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
						apply_break(spell)
					"HEAL":
						apply_heal(spell)
					"SHIELD":
						apply_shield(spell.effects)
				
				print(spell.inv_frames*2)
				hurtbox.start_invincibility(spell.inv_frames)
			"EnemyHitbox":
				var enemy = area.enemy
				apply_damage(enemy.damage)
				hurtbox.start_invincibility(1)


func create_effect(scene, spell_colors):
	var s = scene.instance()
	s.color = spell_colors.COLOR_BASE
	add_child(s)

# ---- React to stimuli -------------

func set_hp(_new):
	hp = clamp(_new, 0, max_hp)
	if hp <= 0:
		die()
	
	emit_signal("updated_health", hp)

func apply_damage(value):
	DJ.play("Damage")
	var damage = value
	if vulnerable:
		damage *= 2
	
	set_hp(hp - damage)
	
	self.material = blink_material
	$BlinkTimer.start(0.2)


func apply_heal(spell):
	DJ.play("Heal")
	set_hp(hp + spell.effects.HEAL)
	create_effect(healParticles, spell.colors)


func apply_stun(spell_effects):
	is_active = false
	emit_signal("player_stunned", is_active)
	$StunIcon.visible = true
	stun_interval = float(spell_effects.STUN)/float($StunIcon.hframes)
	stunTimer.start(spell_effects.STUN)


func apply_break(spell):
	set_vulnerable(true)
	DJ.play("Corruption")
	$BreakTimer.start(spell.effects.BREAK)
	create_effect(corruptionParticles, spell.colors)

func set_vulnerable(_new):
	if vulnerable == _new:
		return
	
	vulnerable = _new
	if _new == true:
		playerBody.scale *= 0.5
	else:
		playerBody.scale *= 2

func apply_shield(spell_effects):
	has_shield = true
	$ShieldTimer.start(spell_effects.SHIELD)
	$ShieldIcon.visible = true

func _on_BlinkTimer_timeout():
	self.material = null

func _on_StunTimer_timeout():
	is_active = true
	$StunIcon.visible = false
	emit_signal("player_stunned", is_active)


func _on_BreakTimer_timeout():
	set_vulnerable(false)

func _on_ShieldTimer_timeout():
	$ShieldIcon.visible = false
	has_shield = false
	print_debug("Shield is out")
	
func _on_ReviveTimer_timeout():
	get_tree().reload_current_scene()

func die():
	DJ.play("GameOver")
	$ReviveTimer.start(1)
	visible = false
	
func get_look_vector():
	return look_vector.normalized()


func _on_Endgame_started_cutscene(end):
	hurtbox.start_invincibility(2000)


func _on_MainUI_started_game():
	is_active = true
