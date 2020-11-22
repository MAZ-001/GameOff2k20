extends Node2D


var loader
var progress_node


func _ready():
	self.progress_node = find_node("progress")
	self.loader = ResourceLoader.load_interactive('res://main.tscn')


func _process(_delta):
	var err = self.loader.poll()
	if err == ERR_FILE_EOF:
		find_node("progress").set_value(100)
		var next_scene = self.loader.get_resource()
		self.loader = null
		var _change_scene = get_tree().change_scene_to(next_scene)
	elif err == OK:
		self.update_progress()


func update_progress():
	var progress = float(self.loader.get_stage()) / self.loader.get_stage_count()
	progress_node.set_value(progress*100)
