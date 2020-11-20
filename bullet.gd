extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score_node: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.score_node = get_node('/root/Spatial/Control/score')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func spawn_particles(body: RigidBody):
	var velocity = body.linear_velocity
	var position = body.global_transform.origin
	var body_material: SpatialMaterial = body.get_material()
	
	var mesh_material = SpatialMaterial.new()
	mesh_material.flags_transparent = true
	mesh_material.vertex_color_use_as_albedo = true
	
	var color: Color = body_material.albedo_color
	
	var texture = GradientTexture.new()
	texture.gradient = Gradient.new()
	texture.gradient.set_color(0, color)
	texture.gradient.set_color(1, Color(color.r, color.g, color.b, 0.0))
	
	var mesh = SphereMesh.new()
	mesh.radius = 0.01
	mesh.height = 0.02
	mesh.radial_segments = 4
	mesh.rings = 4
	mesh.material = mesh_material
	
	var material = ParticlesMaterial.new()
	material.spread = 30
	material.gravity = velocity * 1
	material.initial_velocity = velocity.length()
	material.initial_velocity_random = 0.5
	material.scale = 2
	material.scale_random = 0.5
	material.lifetime_randomness = 1
	material.color_ramp = texture
	material.direction = velocity
	material.emission_shape = ParticlesMaterial.EMISSION_SHAPE_SPHERE
	material.emission_sphere_radius = 0.3
	
	var particles = Particles.new()
	particles.amount = 100
	particles.one_shot = true
	particles.lifetime = 1
	particles.explosiveness = 1
	particles.process_material = material
	particles.draw_pass_1 = mesh
	particles.translation = Vector3(position)
	
	self.get_parent().get_parent().add_child(particles)
	
	for child in self.get_parent().get_parent().get_children():
		if child is Particles:
			if !child.emitting:
				child.queue_free()


func _on_body_entered(body: Node):
	var name = body.get('type')
	if name == null:
		name = body.name
	if name in ['target', 'moon']:
		self.get_parent().queue_free()
		if name == 'target':
			self.spawn_particles(body)
			body.queue_free()
			self.score_node.add_score(1)
