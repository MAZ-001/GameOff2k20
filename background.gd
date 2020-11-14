extends CSGMesh


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	var original_mesh = self.mesh
	var size = mesh.size
	
	var material = SpatialMaterial.new()
	material.set_feature(SpatialMaterial.FEATURE_EMISSION, true)
	material.set_emission(Color.white)
	
	var result = Mesh.new()
	var st = SurfaceTool.new()
	#st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var sphere = SphereMesh.new()
	sphere.radial_segments = 4
	sphere.rings = 1
	for _i in range(0, 10):
		sphere.radius = rand_range(0.001, 0.01)
		sphere.height = sphere.radius
		
		st.set_material(material)
		for _j in range(0, 200):
			var transform = Transform(Vector3(1, 0, 0), Vector3(0, 1, 0), Vector3(0, 0, 1), Vector3(rng.randf_range(-size.x/2, size.x/2), 0, rng.randf_range(-size.y/2, size.y/2)))
		
			st.append_from(sphere, 0, transform)

	st.commit(result)
	st.clear()
	
	print(result)
	self.mesh = result


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
