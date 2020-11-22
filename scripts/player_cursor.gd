extends Spatial

export(NodePath) var camera
export(NodePath) var bullet_spawn
export(NodePath) var shot_origin
export(NodePath) var player_scene

var bullet: PackedScene = preload('res://scenes/bullet_carrot.tscn')

var player_animation: AnimationTree
var camera_node: ClippedCamera
var shot_origin_node: Node
var bullet_spawn_node: Node
var ammo_node: ProgressBar

var drop_plane  = Plane(Vector3(0, 0, 1), 0)
var speed = 0.05


func _ready():
	self.player_animation = get_node(player_scene).find_node('AnimationTree')
	self.camera_node = get_node(camera)
	self.shot_origin_node = get_node(shot_origin)
	self.bullet_spawn_node = get_node(bullet_spawn)
	self.ammo_node = get_node('/root/main_scene/ui/ammo')


func get_target_position():
	var mouse_position = get_viewport().get_mouse_position()
	var from = self.camera_node.project_ray_origin (mouse_position)
	var to = self.camera_node.project_ray_normal(mouse_position)
	var target_position = self.drop_plane.intersects_ray(from, to)
	
	return target_position


func _physics_process(_delta):
	self.ammo_node.value += 0.5
	if (Input.is_action_just_pressed("click")) and self.ammo_node.value >= 50.0:
		self.ammo_node.value -= 50.0
		self.player_animation.set('parameters/throwing/active', true)
		var target_position = get_target_position()
		
		
		var shot_origin_transform = self.shot_origin_node.get_global_transform()
		
		var instance: Node = bullet.instance()
		instance.transform = shot_origin_transform
		instance.transform.looking_at(target_position, Vector3(0, 1, 0))
		instance.translation = instance.translation.move_toward(Vector3(0, 0, 0), -0.5).move_toward(target_position, 0.2)
		instance.scale = Vector3(0.1, 0.1, 0.1)
		instance.linear_velocity = shot_origin_transform.origin.direction_to(target_position) * 3
		instance.angular_velocity = Vector3(rand_range(-5, 5), rand_range(-5, 5), rand_range(-5, 5))
		
		bullet_spawn_node.add_child(instance)
	
	var movement = Vector3(0, 0, 0)
	if Input.is_action_pressed("ui_right"):
		movement += Vector3(0, 0, -1)
	if Input.is_action_pressed("ui_left"):
		movement += Vector3(0, 0, 1)
	
	if movement.length() > 0:
		self.rotate(movement, speed)
