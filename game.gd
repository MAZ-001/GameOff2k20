extends Spatial

var target: PackedScene = load('res://target_basic.tscn')

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = 0
var timer_limit = 2.0

var x_max = 8
var y_max = 6


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_target():
	var instance: Node = target.instance()
	
	var mode = int(rand_range(0, 4))
	if mode == 0:
		instance.translation = Vector3(x_max, rand_range(-y_max, y_max), 0)
	elif mode == 1:
		instance.translation = Vector3(-x_max, rand_range(-y_max, y_max), 0)
	elif mode == 2:
		instance.translation = Vector3(rand_range(-x_max, x_max), y_max, 0)
	elif mode == 3:
		instance.translation = Vector3(rand_range(-x_max, x_max), -y_max, 0)
	
	instance.scale = Vector3(rand_range(0.2, 0.5), rand_range(0.2, 0.5), rand_range(0.2, 0.5))
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
