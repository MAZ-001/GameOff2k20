extends PopupDialog


# Declare member variables here. Examples:
var list_node: ItemList
var upgrade_node: Label

var upgrade_list: Array = []
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	list_node = get_node("list")
	upgrade_node = get_node('/root/main_scene/ui/vbox_right/upgrade_label')
	var main_node = get_node('/root/main_scene')
	
	self.register_upgrade('+1 Moon Hitpoint', 'moon_hitpoint')
	self.register_upgrade('+1 Carrot Ammo', 'carrot_ammo')
	self.register_upgrade('+1 Carrot Recharge', 'carrot_recharge')
	self.register_upgrade('+1 Carrot Shot', 'carrot_shot')
	self.register_upgrade('+1 Carrot Speed', 'carrot_speed')
	self.register_upgrade('Fly me to the Earth', 'fly_me_to_the_earth', main_node.goal)
	

func is_in_list(upgrade: String):
	for idx in range(0, self.list_node.get_item_count()):
		if self.list_node.get_item_metadata(idx) == upgrade:
			return true
	return false


func get_random_upgrade():
	var idx
	while true:
		idx = rng.randi_range(0, self.upgrade_list.size()-1)
		var upgrade = self.upgrade_list[idx]
		if self.is_in_list(upgrade.key):
			continue
		return upgrade


func register_upgrade(title: String, key: String, cost: int = 1):
	self.upgrade_list.append({
		'title': title,
		'key': key,
		'cost': cost,
	})


func add_upgrade(title: String, key: String, cost: int):
	self.list_node.add_item(title + ' (cost: ' + str(cost) + ')')
	var idx = self.list_node.get_item_count()-1
	self.list_node.set_item_metadata(idx, key)


func get_cost(upgrade):
	for idx in range(0, self.upgrade_list.size()):
		if self.upgrade_list[idx]['key'] == upgrade:
			return self.upgrade_list[idx]['cost']

func add_cost(upgrade):
	for idx in range(0, self.upgrade_list.size()):
		if self.upgrade_list[idx]['key'] == upgrade:
			self.upgrade_list[idx]['cost'] += self.upgrade_list[idx]['cost']
			return


func _on_item_selected(index):
	var available_upgrade = self.upgrade_node.upgrade
	var upgrade = self.list_node.get_item_metadata(index)
	var cost = self.get_cost(upgrade)
	if available_upgrade >= cost:
		self.upgrade_node.upgrade -= cost
		get_node('/root/main_scene').apply_upgrade(upgrade)
		self.add_cost(upgrade)
		var new_cost = self.get_cost(upgrade)
		var title: String = self.list_node.get_item_text(index)
		title = title.replace(': ' + str(cost) + ')', ': ' + str(new_cost) + ')')
		self.list_node.set_item_text(index, title)
	self.list_node.unselect_all()


func fill_upgrade_list():
	self.list_node.clear()
	for upgrade in self.upgrade_list:
		self.add_upgrade(upgrade.title, upgrade.key, upgrade.cost)


func _on_continue_button_up():
	get_node('/root/main_scene').next_run()
