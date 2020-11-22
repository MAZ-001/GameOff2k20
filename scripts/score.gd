extends Label


var score = 0


func _process(_delta):
	self.text = 'score: ' + str(self.score)


func add_score(point: int):
	self.score = self.score + point
