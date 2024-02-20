@tool
extends Window

signal add_new_input_action(action_name:String, button:String, controller:int)

@export var add_button:Button
@export var action_line_edit:LineEdit
@export var controller_option:OptionButton

var _button:String


func show_add_action(input_button:String) -> void:
	add_button.disabled = true
	action_line_edit.text = ""
	controller_option.selected = 0
	_button = input_button
	title = "Add Action - Button '%s'" % _button
	show()


func _on_action_line_edit_text_changed(new_text:String):
	var regex = RegEx.new()
	regex.compile("[/=\\:\"]")
	if new_text.is_empty() || regex.search(new_text):
		add_button.disabled = true
		add_button.tooltip_text = "Action name cannot be blank or contain characters '/', ':', '\\', '=', or '\"'"
	elif InputMap.has_action(new_text):
		add_button.disabled = true
		add_button.tooltip_text = "An action with the name '%s' already exists" % new_text
	else:
		add_button.disabled = false
		add_button.tooltip_text = ""


func _on_close_requested():
	hide()


func _on_add_button_pressed():
	add_new_input_action.emit(action_line_edit.text, _button, controller_option.selected)
	hide()
