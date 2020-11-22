extends TextureRect


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	
	self.rect_scale = Vector2(0.5, 0.5)
	self.rect_pivot_offset = self.rect_size / 2
	self.rect_global_position = mouse_position - self.rect_pivot_offset


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_MOUSE_ENTER:
		self.visible = true
	elif what == MainLoop.NOTIFICATION_WM_MOUSE_EXIT:
		self.visible = false
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		self.visible = true
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		self.visible = false
