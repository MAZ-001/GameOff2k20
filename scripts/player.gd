extends RigidBody

export(NodePath) var player_cursor
export(NodePath) var player_scene
export(NodePath) var moon_script
export(NodePath) var camera

var player_cursor_node
var player_scene_node
var rot_node
var player_animation: AnimationTree
var particles_left: Particles
var particles_right: Particles
var moon_script_node: Node
var camera_node: ClippedCamera

func _ready():
	player_cursor_node = get_node(player_cursor)
	player_scene_node = get_node(player_scene)
	moon_script_node = get_node(moon_script)
	camera_node = get_node(camera)
	rot_node = self.player_cursor_node.get_parent()
	player_animation = player_scene_node.find_node('AnimationTree')
	particles_left = player_scene_node.find_node('Particles_left')
	particles_right = player_scene_node.find_node('Particles_right')


func _integrate_forces(state):
	var target = self.player_cursor_node.global_transform.origin
	var local = self.to_local(target)
	if local.x > 0.1:
		player_scene_node.scale = Vector3(-0.1, 0.1, -0.1)
	if local.x < -0.1:
		player_scene_node.scale = Vector3(0.1, 0.1, 0.1)
	
	var t = state.get_transform()
	
	var r = Vector3(0, 0, self.rot_node.rotation.z)

	var new = Transform(r, t.origin)
	state.set_transform(new)


func _process(_delta):
	var transform = self.player_cursor_node.get_global_transform()
	var distance = transform.origin.distance_to(self.translation)

	if distance > 0.01:
		var velocity = self.translation.direction_to(transform.origin) * distance * 5
		var uplift = -self.translation.direction_to(Vector3(0, 0, 0)) * distance * 2.5
		self.linear_velocity = velocity + uplift
	
	player_animation.set('parameters/hover/blend_amount', distance*2)
	self.particles_left.process_material.initial_velocity = -1 - (distance * 50)
	self.particles_right.process_material.initial_velocity = -1 - (distance * 50)


func _on_body_entered(body: Node):
	var name = body.get('type')
	if name == null:
		name = body.name
	if name in ['target']:
		self.moon_script_node.spawn_particles(body)
		self.camera_node.enable_shake()
		body.queue_free()
