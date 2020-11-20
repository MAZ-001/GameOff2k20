extends Spatial

var target: PackedScene = load('res://target_basic.tscn')
var target_asteroid: PackedScene = load('res://target_asteroid.tscn')
var target_cheese: PackedScene = load('res://target_cheese.tscn')

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = 0
var timer_limit = 2.0

var x_max = 8
var y_max = 6
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()

	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if (timer > timer_limit):
		spawn_target()
		timer -= timer_limit
