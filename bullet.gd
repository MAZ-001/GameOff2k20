extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score_node: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	self.score_node = get_node('/root/Spatial/Control/score')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_body_entered(body: Node):
	var name = body.get('type')
	if name == null:
		name = body.name
	if name in ['target', 'moon']:
		self.get_parent().queue_free()
		if name == 'target':
			body.queue_free()
			self.score_node.add_score(1)
