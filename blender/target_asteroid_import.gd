tool # Needed so it runs in the editor.
extends EditorScenePostImport


# Called right after the scene is imported and gets the root node
func post_import(scene: Object):
	var collision_shape: CollisionShape = scene.find_node('shape0')
	var collision_shape_clone = collision_shape.duplicate()
	
	scene.find_node('shape0').free()
	scene.find_node('target_asteroid_collision').free()
	
	collision_shape_clone.name = 'target_asteroid_collision'
	collision_shape_clone.shape.margin = 0.001
	scene.add_child(collision_shape_clone)
	collision_shape_clone.set_owner(scene)

	return scene # Remember to return the imported scene
