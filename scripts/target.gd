extends Node

export(String) var type


func get_material():
	var mesh_instance : MeshInstance = find_node('cheese')
	if mesh_instance != null:
		return mesh_instance.get_surface_material(0)
	mesh_instance = find_node('target_asteroid')
	if mesh_instance != null:
		return mesh_instance.get_surface_material(0)
	return SpatialMaterial.new()
