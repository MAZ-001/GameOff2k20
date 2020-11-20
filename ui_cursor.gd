extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	
	self.rect_scale = Vector2(0.5, 0.5)
	self.rect_pivot_offset = self.rect_size / 2
	self.rect_global_position = mouse_position - self.rect_pivot_offset
