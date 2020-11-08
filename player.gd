extends RigidBody

export(NodePath) var player_cursor

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

func _integrate_forces(state):
	var xform = state.get_transform().looking_at(Vector3(0.01, 0, 0), Vector3(0, 1, 0))
	state.set_transform(xform)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_cursor_node = get_node(player_cursor)
	
	var transform = player_cursor_node.get_global_transform()
	var distance = transform.origin.distance_to(self.translation)

	if distance > 0.01:
		var velocity = self.translation.direction_to(transform.origin) * distance * 5
		var uplift = -self.translation.direction_to(Vector3(0, 0, 0)) * distance * 2
		self.linear_velocity = velocity + uplift
