extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var loader
var current_scene
var next_scene
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)


func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	find_node("progress").set_value(progress*100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if loader == null and next_scene == null:
		loader = ResourceLoader.load_interactive('res://main.tscn')
		set_process(true)
	else:
		if next_scene == null:
			var err = loader.poll()
			if err == ERR_FILE_EOF:
				find_node("progress").set_value(100)
				next_scene = loader.get_resource()
				loader = null
			elif err == OK:
				update_progress()
		else:
			get_tree().change_scene_to(next_scene)

