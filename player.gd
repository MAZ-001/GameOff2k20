extends RigidBody

export(NodePath) var player_cursor
export(NodePath) var player_scene

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

func _integrate_forces(state):
	var player_cursor_node = get_node(player_cursor)
	var target = player_cursor_node.global_transform.origin
	var local = self.to_local(target)
	if local.x > 0:
		get_node(player_scene).scale = Vector3(-0.1, 0.1, -0.1)
	if local.x < 0:
		get_node(player_scene).scale = Vector3(0.1, 0.1, 0.1)
	
	
	var rot_node = player_cursor_node.get_parent()
	var t = state.get_transform()
	
	var r = Vector3(0, 0, rot_node.rotation.z)

	var new = Transform(r, t.origin)
	state.set_transform(new)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_cursor_node = get_node(player_cursor)
	
	var transform = player_cursor_node.get_global_transform()
	var distance = transform.origin.distance_to(self.translation)

	if distance > 0.01:
		var velocity = self.translation.direction_to(transform.origin) * distance * 5
		var uplift = -self.translation.direction_to(Vector3(0, 0, 0)) * distance * 2.5
		self.linear_velocity = velocity + uplift
	
	get_node(player_scene).find_node('AnimationTree').set('parameters/hover/blend_amount', distance*2)


func _on_body_entered(body: Node):
	var name = body.get('type')
	if name == null:
		name = body.name
	if name in ['target']:
		body.queue_free()
