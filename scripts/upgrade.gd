extends Label


var upgrade = 0
var goal


func _ready():
	self.goal = get_node('/root/main_scene').goal


func _process(_delta):
	self.text = 'cheese: ' + str(self.upgrade)


func add_upgrade(point: int):
	self.upgrade = self.upgrade + point
	if self.upgrade == self.goal:
		get_node('/root/main_scene').open_finished()
