extends Button


var pause_popup_node: PopupDialog


# Called when the node enters the scene tree for the first time.
func _ready():
	self.pause_popup_node = self.get_parent()


func _process(_delta):
	if Input.is_action_just_pressed("ui_pause") and self.pause_popup_node.visible:
		self._on_button_up()


func _on_button_up():
	get_tree().paused = false
	self.pause_popup_node.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_node('/root/main_scene/ui/main_menu').hide()
