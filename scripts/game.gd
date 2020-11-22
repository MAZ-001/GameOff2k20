extends Spatial

export(NodePath) var target_spawn

var timer = 0
var timer_limit = 2.0
var target_spawn_node: Spatial
var hit_container: HBoxContainer
var hit_node: ProgressBar
var score_label: Label

var health = 1
var hits = 0


func _ready():
	target_spawn_node = get_node(target_spawn)
	hit_container = get_node("ui/HBoxContainer")
	hit_node = hit_container.get_child(0)
	hit_container.remove_child(hit_node)
	score_label = get_node("ui/score_label")
	
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()

	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	
	self.reset()
	

func _process(delta):
	timer += delta
	if (timer > timer_limit):
		target_spawn_node.spawn_target()
		timer -= timer_limit


func remove_children(node: Node):
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()

func reset():
	self.hits = 0
	self.remove_children(hit_container)
	score_label.score = 0
	
	for _i in range(0, self.health):
		hit_container.add_child(hit_node.duplicate())
	

func add_hit():
	self.hits += 1
	for child in hit_container.get_children():
		if child.value == 0:
			child.value = 1
			break
	
	if self.hits >= self.health:
		self.health += 1
		self.reset()
