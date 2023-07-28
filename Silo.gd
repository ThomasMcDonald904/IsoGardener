extends ItemList


var items = []

func get_all_first_elements(list: Array) -> Array:
	var holder = []
	for i in list:
		holder.append(i[0])
	return holder

# Called when the node enters the scene tree for the first time.
func _ready():
	for crop in globals.crops_available:
		items.append(crop)
		add_item("", crop[0].icon) 

func _on_item_clicked(index, _at_position, _mouse_button_index):
	if  globals.crops_available[index][1] != 0:
		globals.selected_crop = globals.crops_available[index]


func _process(_delta):
	for crop in globals.crops_available:
		if crop[1] == 0:
			set_item_selectable(globals.crops_available.find(crop), false)
			set_item_disabled(globals.crops_available.find(crop), true)
		else:
			set_item_selectable(globals.crops_available.find(crop), true)
			set_item_disabled(globals.crops_available.find(crop), false)
		if crop[0] not in get_all_first_elements(items):
			items.append(crop)
			add_item("", crop[0].icon) 
	if Input.is_action_just_released("leftclick") and not Rect2(Vector2(), size).has_point(get_local_mouse_position()) and not globals.mouse_on_ground:
		deselect_all()
		globals.selected_crop = []
