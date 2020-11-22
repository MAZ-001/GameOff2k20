extends Spatial

var target: PackedScene = preload('res://scenes/target_basic.tscn')
var target_asteroid: PackedScene = preload('res://scenes/target_asteroid.tscn')
var target_cheese: PackedScene = preload('res://scenes/target_cheese.tscn')

var x_max = 8
var y_max = 6
var rng = RandomNumberGenerator.new()

func spawn_target():
	var instance: Node
	var target_type: int = rng.randi_range(1, 2)
	
	if target_type == 0:
		instance = target.instance()
		instance.scale = Vector3(rand_range(0.2, 0.5), rand_range(0.2, 0.5), rand_range(0.2, 0.5))
	elif target_type == 1:
		instance = target_asteroid.instance()
		instance.scale = Vector3(rand_range(0.1, 0.4), rand_range(0.1, 0.4), rand_range(0.1, 0.4))
	elif target_type == 2:
		instance = target_cheese.instance()
		instance.scale = Vector3(rand_range(0.5, 1.0), rand_range(0.5, 1), rand_range(0.5, 1.0))
	
	var mode = rng.randi_range(0, 3)
	if mode == 0:
		instance.translation = Vector3(x_max, rand_range(-y_max, y_max), 0)
	elif mode == 1:
		instance.translation = Vector3(-x_max, rand_range(-y_max, y_max), 0)
	elif mode == 2:
		instance.translation = Vector3(rand_range(-x_max, x_max), y_max, 0)
	elif mode == 3:
		instance.translation = Vector3(rand_range(-x_max, x_max), -y_max, 0)
	
	instance.rotation = Vector3(rand_range(0.0, 1), rand_range(0, 1), rand_range(0, 1))
	instance.linear_velocity = instance.translation.direction_to(Vector3(rand_range(-2, 2), rand_range(-2, 2), 0)) * rand_range(1, 3)
	instance.angular_velocity = Vector3(rand_range(-1, 1), rand_range(-1, 1), rand_range(-1, 1))
	
	self.add_child(instance)
