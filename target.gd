extends Node

export(String) var type

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

func get_material():
	var mesh_instance : MeshInstance = find_node('cheese')
	if mesh_instance != null:
		return mesh_instance.get_surface_material(0)
	mesh_instance = find_node('target_asteroid')
	if mesh_instance != null:
		return mesh_instance.get_surface_material(0)
	return SpatialMaterial.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
