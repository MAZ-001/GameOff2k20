extends Area


var bullet_spawn_node: Node
var score_node: Node = null
var camera_node: ClippedCamera

func _ready():
	self.bullet_spawn_node = get_node('/root/main_scene/bullet_spawn')
	self.score_node = get_node('/root/main_scene/ui/score_label')
	self.camera_node = get_node('/root/main_scene/camera_target/camera')


func _on_body_entered(body: Node):
	var name = body.get('type')
	if name == null:
		name = body.name
	if name in ['target', 'moon']:
		self.get_parent().queue_free()
		if name == 'target':
			self.bullet_spawn_node.spawn_particles(body)
			body.queue_free()
			self.score_node.add_score(1)
			#self.camera_node.enable_shake()
