@tool
extends Control

@export var input_action_tree:Tree

@export_group("Player 1 Controls")
@export var p1_start:Button
@export var p1_insert_credit:Button
@export_subgroup("Joystick")
@export var p1_up:Button
@export var p1_left:Button
@export var p1_right:Button
@export var p1_down:Button
@export_subgroup("Buttons")
@export var p1_a:Button
@export var p1_b:Button
@export var p1_c:Button
@export var p1_x:Button
@export var p1_y:Button
@export var p1_z:Button
@export_group("Player 2 Controls")
@export var p2_start:Button
@export var p2_insert_credit:Button
@export_subgroup("Joystick")
@export var p2_up:Button
@export var p2_left:Button
@export var p2_right:Button
@export var p2_down:Button
@export_subgroup("Buttons")
@export var p2_a:Button
@export var p2_b:Button
@export var p2_c:Button
@export var p2_x:Button
@export var p2_y:Button
@export var p2_z:Button

var _action_tree_root:TreeItem


func _ready() -> void:
	_setup_action_tree()
	input_action_tree.deselect_all()


func _setup_action_tree() -> void:
	_action_tree_root = input_action_tree.create_item()
	for action in InputMap.get_actions():
		if action.begins_with("ui_"):
			continue
		var action_item:TreeItem = _action_tree_root.create_child()
		action_item.set_text(0, action)


func _set_buttons_disabled(disabled:bool) -> void:
	p1_start.disabled = disabled
	p1_insert_credit.disabled = disabled
	p1_up.disabled = disabled
	p1_left.disabled = disabled
	p1_right.disabled = disabled
	p1_down.disabled = disabled
	p1_a.disabled = disabled
	p1_b.disabled = disabled
	p1_c.disabled = disabled
	p1_x.disabled = disabled
	p1_y.disabled = disabled
	p1_z.disabled = disabled
	p2_start.disabled = disabled
	p2_insert_credit.disabled = disabled
	p2_up.disabled = disabled
	p2_left.disabled = disabled
	p2_right.disabled = disabled
	p2_down.disabled = disabled
	p2_a.disabled = disabled
	p2_b.disabled = disabled
	p2_c.disabled = disabled
	p2_x.disabled = disabled
	p2_y.disabled = disabled
	p2_z.disabled = disabled


func _set_buttons_button_pressed(button_pressed:bool) -> void:
	p1_start.button_pressed = button_pressed
	p1_insert_credit.button_pressed = button_pressed
	p1_up.button_pressed = button_pressed
	p1_left.button_pressed = button_pressed
	p1_right.button_pressed = button_pressed
	p1_down.button_pressed = button_pressed
	p1_a.button_pressed = button_pressed
	p1_b.button_pressed = button_pressed
	p1_c.button_pressed = button_pressed
	p1_x.button_pressed = button_pressed
	p1_y.button_pressed = button_pressed
	p1_z.button_pressed = button_pressed
	p2_start.button_pressed = button_pressed
	p2_insert_credit.button_pressed = button_pressed
	p2_up.button_pressed = button_pressed
	p2_left.button_pressed = button_pressed
	p2_right.button_pressed = button_pressed
	p2_down.button_pressed = button_pressed
	p2_a.button_pressed = button_pressed
	p2_b.button_pressed = button_pressed
	p2_c.button_pressed = button_pressed
	p2_x.button_pressed = button_pressed
	p2_y.button_pressed = button_pressed
	p2_z.button_pressed = button_pressed


func _update_buttons_for_action(input_action:StringName) -> void:
	_set_buttons_disabled(false)
	_set_buttons_button_pressed(false)
	var action = ProjectSettings.get("input/%s" % input_action)


func _on_input_actions_tree_nothing_selected():
	_set_buttons_disabled(true)
	_set_buttons_button_pressed(false)
