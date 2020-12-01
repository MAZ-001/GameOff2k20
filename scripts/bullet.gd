extends Area


var bullet_spawn_node: Node
var score_node: Node = null
var upgrade_node: Node = null
var camera_node: ClippedCamera

func _ready():
	self.bullet_spawn_node = get_node('/root/main_scene/bullet_spawn')
	self.score_node = get_node('/root/main_scene/ui/vbox_right/score_label')
	self.upgrade_node = get_node('/root/main_scene/ui/vbox_right/upgrade_label')
	self.camera_node = get_node('/root/main_scene/camera_target/camera')


func _on_body_entered(body: Node):
	var name = body.get('type')
	if name == null:
		name = body.name
	if name in ['target', 'moon']:
		self.get_parent().queue_free()
		if name == 'target':
			self.bullet_spawn_node.spawn_particles(body)
			if body.find_node('cheese'):
				var particles = body.find_node('Particles')
				body.remove_child(particles)
				var particle_node = get_node('/root/main_scene/particle_spawn')
				particle_node.add_child(particles)
				self.upgrade_node.add_upgrade(1)
			body.queue_free()
			self.score_node.add_score(1)
