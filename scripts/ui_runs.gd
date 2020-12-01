extends Label


var runs: int


func _ready():
	self.runs = 1


func _process(_delta):
	self.text = 'runs: %s' % self.runs
