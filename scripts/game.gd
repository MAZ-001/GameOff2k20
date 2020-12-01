extends Spatial

export(NodePath) var target_spawn

var timer = 0
var timer_limit = 2.0
var target_spawn_node: Spatial
var hit_container: HBoxContainer
var hit_node: ProgressBar
var score_label: Label
var upgrade_label: Label
var pause_popup_node: PopupDialog
var main_menu_node: PopupDialog

var health = 1
var hits = 0
var goal = 50


func _ready():
	target_spawn_node = get_node(target_spawn)
	hit_container = get_node("ui/HBoxContainer")
	hit_node = hit_container.get_child(0)
	hit_node.value = 1
	hit_container.remove_child(hit_node)
	score_label = get_node("ui/vbox_right/score_label")
	upgrade_label = get_node("ui/vbox_right/upgrade_label")
	pause_popup_node = get_node("ui/pause_popup")
	main_menu_node = get_node("ui/main_menu")
	
	self.reset()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	main_menu_node.popup()
	

func restart():
	get_node("ui/VBoxContainer/time_label").time = 0.0
	get_node("ui/VBoxContainer/runs_label").runs = 0
	self.health = 1
	self.upgrade_label.upgrade = 0
	self.reset()

func _process(delta):
	timer += delta
	if (timer > timer_limit):
		target_spawn_node.spawn_target()
		timer -= timer_limit
	
	if Input.is_action_just_pressed("ui_menu"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		main_menu_node.popup()
	if Input.is_action_just_pressed('ui_pause'):
		Input.action_release('ui_pause')
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_popup_node.popup()


func remove_children(node: Node):
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()

func reset():
	self.hits = 0
	self.remove_children(hit_container)
	score_label.score = 0
	
	for _i in range(0, self.health):
		hit_container.add_child(hit_node.duplicate())
	
	self.remove_children(get_node("target_spawn"))
	self.remove_children(get_node("bullet_spawn"))
	

func add_hit():
	self.hits += 1
	var children = hit_container.get_children()
	children.invert()
	for child in children:
		if child.value == 1:
			child.value = 0
			break
	
	if self.hits >= self.health:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		get_node("ui/run_failed").popup()


func _on_choose_upgrade_button_up():
	get_node("ui/run_failed").hide()
	get_node("ui/upgrade_select").fill_upgrade_list()
	get_node("ui/upgrade_select").popup()


func open_finished():
	get_tree().paused = true
	get_node("ui/choose").popup()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func go_to_earth():
	get_node("ui/choose").hide()
	get_node("ui/finished").popup()
	get_node("ui/upgrade_select").hide()


func apply_upgrade(upgrade: String):
	if upgrade == 'moon_hitpoint':
		self.health += 1
	elif upgrade == 'carrot_ammo':
		get_node("moon/player_cursor").apply_upgrade(upgrade)
	elif upgrade == 'carrot_recharge':
		get_node("moon/player_cursor").apply_upgrade(upgrade)
	elif upgrade == 'carrot_shot':
		get_node("moon/player_cursor").apply_upgrade(upgrade)
	elif upgrade == 'carrot_speed':
		get_node("moon/player_cursor").apply_upgrade(upgrade)
	elif upgrade == 'fly_me_to_the_earth':
		self.go_to_earth()
	else:
		print('unknown upgrade %s' % upgrade)


func next_run():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_node("ui/upgrade_select").hide()
	self.reset()
	get_node("ui/VBoxContainer/runs_label").runs += 1
	get_tree().paused = false


func _on_new_game_button_up():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	main_menu_node.hide()
	get_node("ui/finished").hide()
	get_tree().paused = false
	self.restart()


func _on_quit_button_up():
	get_tree().quit()


func _on_close_intro_button_up():
	get_node("ui/intro").hide()


func _on_intro_button_up():
	get_node("ui/intro").popup()


func _on_earth_button_up():
	self.go_to_earth()


func _on_continue_button_up():
	get_node("ui/choose").hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().paused = false
