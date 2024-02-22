@tool
extends Control

@export var input_action_tree:Tree

@export var buttons:Array[PlayerButton]

var _action_tree_root:TreeItem


func _ready() -> void:
	ProjectSettings.settings_changed.connect(_setup_action_tree)
	_setup_action_tree()
	input_action_tree.deselect_all()


func _setup_action_tree() -> void:
	input_action_tree.clear()
	_action_tree_root = input_action_tree.create_item()
	var actions = ProjectSettings.get_property_list().filter(func(x): return x["name"].begins_with("input/"))
	for action in actions:
		if action["name"].begins_with("input/ui_"):
			continue
		var action_item:TreeItem = _action_tree_root.create_child()
		action_item.set_text(0, action["name"].trim_prefix("input/"))


func _set_buttons_disabled(disabled:bool) -> void:
	for button in buttons:
		button.disabled = disabled


func _set_buttons_button_pressed(button_pressed:bool) -> void:
	for button in buttons:
		button.button_pressed = button_pressed


func _update_buttons_for_action(input_action:StringName) -> void:
	_set_buttons_disabled(false)
	_set_buttons_button_pressed(false)
	var action = ProjectSettings.get("input/%s" % input_action)
	if action == null:
		return
	var buttons = _get_buttons_matching_action(action)
	for button:PlayerButton in buttons:
		button.button_pressed = true


func _get_buttons_matching_action(action:Dictionary) -> Array[PlayerButton]:
	if !action.has("events"):
		printerr("Action has no events!")
		return []
	var result:Array[PlayerButton] = []
	for button in buttons:
		if _get_button_events(button) == action["events"]:
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
