@tool
extends Control

@export var input_action_tree:Tree
@export var show_built_in_actions_checkbutton:CheckButton

@export var buttons:Array[PlayerButton]

var _action_tree_root:TreeItem


func _ready() -> void:
	_setup_action_tree()
	for button in buttons:
		button.toggled.connect(_on_button_toggled.bind(button))
	input_action_tree.deselect_all()


func _setup_action_tree() -> void:
	input_action_tree.clear()
	_action_tree_root = input_action_tree.create_item()
	var actions = ProjectSettings.get_property_list().filter(func(x): return x["name"].begins_with("input/"))
	for action in actions:
		if action["name"].begins_with("input/ui_"):
			continue
		if action["name"].begins_with("input/bgs") && !show_built_in_actions_checkbutton.button_pressed:
			continue
		var action_item:TreeItem = _action_tree_root.create_child()
		action_item.set_text(0, action["name"].trim_prefix("input/"))


func _set_buttons_disabled(disabled:bool) -> void:
	for button in buttons:
		button.disabled = disabled


func _set_buttons_button_pressed(button_pressed:bool) -> void:
	for button in buttons:
		button.set_pressed_no_signal(button_pressed)


func _update_buttons_for_action(input_action:StringName) -> void:
	_set_buttons_disabled(false)
	_set_buttons_button_pressed(false)
	var action = ProjectSettings.get("input/%s" % input_action)
	if action == null:
		return
	var buttons = _get_buttons_matching_action(action)
	print_debug(buttons)
	for button:PlayerButton in buttons:
		button.set_pressed_no_signal(true)


func _get_buttons_matching_action(action) -> Array[PlayerButton]:
	if action is Array:
		printerr("Action is an array!") 
		return []
	if !action.has("events"):
		printerr("Action has no events!")
		return []
	var result:Array[PlayerButton] = []
	for button in buttons:
		var matches:= 0
		var button_events = _get_button_events(button)
		for event in button_events:
			for action_event in action["events"]:
				if event.is_match(action_event):
					matches +=1
		if button_events.size() == matches:
			result.append(button)
	return result


func _get_button_events(player_button:PlayerButton) -> Array:
	var temp_events:= []
	temp_events.append_array(player_button.action.joy_button_events)
	temp_events.append_array(player_button.action.joy_motion_events)
	temp_events.append_array(player_button.action.key_events)
	return temp_events


func _on_input_actions_tree_nothing_selected():
	_set_buttons_disabled(true)
	_set_buttons_button_pressed(false)


func _on_input_actions_tree_cell_selected():
	var action_selected:TreeItem = input_action_tree.get_selected()
	_update_buttons_for_action(action_selected.get_text(0))


func _on_built_in_actions_check_button_toggled(_toggled_on):
	_setup_action_tree()


func _on_button_toggled(toggled_on:bool, button:PlayerButton) -> void:
	print_debug("Button '%s' toggled: %s" % [button.name, toggled_on])
	var selected_action:TreeItem = input_action_tree.get_selected()
	if selected_action == null:
		return
	var action_name = selected_action.get_text(0)
	if action_name.begins_with("bgs_"):
		button.set_pressed_no_signal(!toggled_on)
		return
	var temp_events:Array 
	if ProjectSettings.get("input/%s" % action_name).has("events"):
		temp_events = ProjectSettings.get("input/%s" % action_name)["events"]
	else:
		temp_events = []
	var button_events:Array
	button_events.append_array(button.action.joy_button_events)
	button_events.append_array(button.action.joy_motion_events)
	button_events.append_array(button.action.key_events)
	if toggled_on:
		print_debug("Adding events")
		for event in button_events:
			if temp_events.size() > 0:
				var has_event:= false
				for temp_event in temp_events:
					if temp_event.is_match(event):
						has_event = true
				if !has_event:
					temp_events.append(event)
			else:
				temp_events.append(event)
	else:
		print_debug("Removing events")
		for event in button_events:
			if temp_events.size() > 0:
				for temp_event in temp_events:
					if temp_event.is_match(event):
						temp_events.erase(temp_event)
	ProjectSettings.get("input/%s" % action_name)["events"] = temp_events
	var result = ProjectSettings.save()
	if result != 0:
		printerr("Error saving ProjectSettings: %s" % error_string(result))
