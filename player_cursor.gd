extends Spatial

export(NodePath) var camera
export(NodePath) var world
export(NodePath) var shot_origin

var bullet: PackedScene = load('res://bullet.tscn')

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 0.05


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_target_position():
	var drop_plane  = Plane(Vector3(0, 0, 1), 0)

	var camera_node: ClippedCamera = get_node(camera)
	var mouse_position = get_viewport().get_mouse_position()
	var from = camera_node.project_ray_origin (mouse_position)
	var to = camera_node.project_ray_normal(mouse_position)
	var target_position = drop_plane.intersects_ray(from, to)
	
	return target_position

# Called every physics frame.
func _physics_process(_delta):
	if (Input.is_action_just_pressed("click")):
		var target_position = get_target_position()
		
		var shot_origin_node: Node = get_node(shot_origin)
		var shot_origin_transform = shot_origin_node.get_global_transform()
		
		var instance: Node = bullet.instance()
		instance.transform = shot_origin_transform.looking_at(target_position, Vector3(0, 1, 0))
		instance.linear_velocity = shot_origin_transform.origin.direction_to(target_position) * 2.5
		
		var world_node: Node = get_node(world)
		world_node.add_child(instance)
	
	var movement = Vector3(0, 0, 0)
	if Input.is_action_pressed("ui_right"):
		movement += Vector3(0, 0, -1)
	if Input.is_action_pressed("ui_left"):
		movement += Vector3(0, 0, 1)
	
	if movement.length() > 0:
		self.rotate(movement, speed)
