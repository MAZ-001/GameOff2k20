extends Area

export(NodePath) var particle_spawn

var max_particles = 3

var camera_node: ClippedCamera

var material: SpatialMaterial
var mesh: SphereMesh
var particles: Array
var particle_spawn_node: Spatial


func _ready():
	self.camera_node = get_node('/root/main_scene/camera_target/camera')
	
	particle_spawn_node = get_node(particle_spawn)
	
	material = SpatialMaterial.new()
	material.flags_transparent = true
	material.vertex_color_use_as_albedo = true
	
	mesh = SphereMesh.new()
	mesh.radius = 0.01
	mesh.height = 0.02
	mesh.radial_segments = 4
	mesh.rings = 4
	mesh.material = material
	
	var particle: Particles
	for _i in range(0, max_particles):
		particle = self.init_particles()
		particle.emitting = false
		self.particles.append(particle)
		self.particle_spawn_node.add_child(particle)


func init_particles() -> Particles:
	var texture = GradientTexture.new()
	texture.gradient = Gradient.new()
	
	var particles_material = ParticlesMaterial.new()
	particles_material.spread = 30
	particles_material.initial_velocity_random = 0.5
	particles_material.scale = 2
	particles_material.scale_random = 0.5
	particles_material.lifetime_randomness = 1
	particles_material.emission_shape = ParticlesMaterial.EMISSION_SHAPE_SPHERE
	particles_material.emission_sphere_radius = 0.3
	particles_material.color_ramp = texture
	
	var particles = Particles.new()
	particles.amount = 100
	particles.one_shot = true
	particles.lifetime = 1
	particles.explosiveness = 1
	particles.process_material = particles_material
	particles.draw_pass_1 = mesh
	
	return particles


func spawn_particles(body: RigidBody):
	var velocity = body.linear_velocity
	var position = body.global_transform.origin
	var body_material: SpatialMaterial = body.get_material()
	
	var color: Color = body_material.albedo_color
	
	var particle: Particles = particles.pop_front()
	
	particle.process_material.color_ramp.gradient.set_color(0, color)
	particle.process_material.color_ramp.gradient.set_color(1, Color(color.r, color.g, color.b, 0.0))
	
	particle.process_material.gravity = velocity * 1
	particle.process_material.initial_velocity = velocity.length() * 2
	particle.process_material.direction = velocity
	particle.translation = Vector3(position)
	
	particle.restart()
	particles.append(particle)


func _on_body_entered(body: Node):
	var name = body.get('type')
	if name == null:
		name = body.name
	if name in ['target']:
		self.spawn_particles(body)
		body.queue_free()
		get_node('/root/main_scene').add_hit()
		self.camera_node.enable_shake()
