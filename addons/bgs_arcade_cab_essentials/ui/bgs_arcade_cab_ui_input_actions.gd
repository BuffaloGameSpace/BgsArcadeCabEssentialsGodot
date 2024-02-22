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


func _get_buttons_matching_action(action:Dictionary) -> PlayerButton:
	if !action.has("events"):
		return null
	var joy_buttons:Array[JoyButton]
	var joy_axis:Array[JoyAxis]
	var keys:Array[Key]
	for event in action["events"]:
		if event is InputEventJoypadButton:
			joy_buttons.append(event.button_index)
		if event is InputEventJoypadMotion:
			joy_axis.append(event.axis)
		if event is InputEventKey:
			keys.append(event.physical_keycode)
	var result = buttons.filter(func(x:PlayerButton): return x.joy_button_inputs == joy_buttons && x.joy_axis_inputs == joy_axis && x.key_inputs == keys)
	return result


func _on_input_actions_tree_nothing_selected():
	_set_buttons_disabled(true)
	_set_buttons_button_pressed(false)


func _on_input_actions_tree_cell_selected():
	var action_selected:TreeItem = input_action_tree.get_selected()
	_update_buttons_for_action(action_selected.get_text(0))
