extends Control

var crop = null

func get_all_first_elements(list: Array) -> Array:
	var holder = []
	for i in list:
		holder.append(i[0])
	return holder



func _ready():
	globals.crops_in_market.sort_custom(func(a, b): return a.buy_price < b.buy_price)
	for crop in globals.crops_in_market:
		$"HBoxContainer/PanelContainer/VBoxContainer/AvailableSeeds".add_item(crop.crop_name + " - " + str(crop.buy_price) + "$", crop.icon)

func _on_available_seeds_item_clicked(index, at_position, mouse_button_index):
	$HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Amount.value = 1
	crop = globals.crops_in_market[index]
	var final_amount = crop.buy_price * $HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Amount.value
	$HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer2/PurchaseName.text = crop.crop_name
	$HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Price.text = str(crop.buy_price) + "$"
	$HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Total.text = "[color=80c511]" + str(final_amount) if final_amount <= globals.money else "[color=cb0b0b]" + str(final_amount)
	update_purchase_button(final_amount)


func _on_amount_value_changed(value):
	if crop != null:
		var final_amount = crop.buy_price * value
		$HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer2/PurchaseName.text = crop.crop_name
		$HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Price.text = str(crop.buy_price) + "$"
		$HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Total.text = "[color=80c511]" + str(final_amount) if final_amount <= globals.money else "[color=cb0b0b]" + str(final_amount)
		update_purchase_button(final_amount)


func update_purchase_button(_final_amount: int):
	var button = $HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/Purchase
	if _final_amount > globals.money:
		button.text = "funds insufficient"
		button.set_modulate("cb0b0b")
		$HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Total.text = "[color=cb0b0b]" + str(_final_amount)
	else:
		button.text = "purchase"
		button.set_modulate("ffffff")
		$HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Total.text = "[color=80c511]" + str(_final_amount)




func _on_purchase_button_up():
	if crop != null:
		var button = $HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/Purchase
		var final_amount = int($HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Total.text.split("]")[1])
		var amount = int($HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Amount.value)
		update_purchase_button(final_amount)
		if button.text != "funds insufficient":
			globals.money -= final_amount
			if crop not in get_all_first_elements(globals.crops_available):
				globals.crops_available.append([crop, amount])
			else:
				globals.crops_available[get_all_first_elements(globals.crops_available).find(crop)][1] += amount


func _on_max_button_up():
	if crop != null:
		var amount = $HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Amount
		amount.value = floori(globals.money / crop.buy_price)
