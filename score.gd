extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = 'score: ' + str(self.score)


func add_score(score):
	self.score = self.score + score
