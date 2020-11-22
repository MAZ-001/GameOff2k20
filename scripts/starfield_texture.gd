extends CSGMesh


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_viewport().size
	var scale = 1.5
	
	var image = Image.new()
	image.create(size.x*scale, size.y*scale, false, Image.FORMAT_RGBA8)
	image.lock()
	var color = Color.white
	var x
	var y
	for r in range(1, 4):
		for _j in range(0, 500):
			color.a = rng.randf_range(0.0, 1)
			x = rng.randi_range(0, image.get_size().x-2)
			y = rng.randi_range(0, image.get_size().y-2)
			image.set_pixel(x, y, color)
			if r >= 2:
				image.set_pixel(x+1, y, color)
			if r >= 3:
				image.set_pixel(x, y+1, color)
			if r >= 4:
				image.set_pixel(x+1, y+1, color)
			
	image.unlock()

	
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	
	var material = SpatialMaterial.new()
	material.flags_unshaded = true
	material.albedo_texture = texture
	self.mesh.material = material


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
