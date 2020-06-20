extends CPUParticles2D

onready var parent = get_parent()

func _ready():
	if parent.get_node("CollisionShape2D").shape is RectangleShape2D:
		self.emission_shape = CPUParticles2D.EMISSION_SHAPE_RECTANGLE
		self.emission_rect_extents = parent.get_node("CollisionShape2D").shape.extents
	if parent.get_node("CollisionShape2D").shape is CircleShape2D:
		self.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
		self.emission_sphere_radius = parent.get_node("CollisionShape2D").shape.radius
	z_index = 1


func _on_Timer_timeout():
	queue_free()
