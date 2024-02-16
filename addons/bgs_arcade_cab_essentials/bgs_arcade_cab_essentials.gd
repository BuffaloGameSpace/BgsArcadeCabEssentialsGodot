@tool
extends EditorPlugin

#region Input constants
const general_buttons = {
	"bgs_up": [JOY_BUTTON_DPAD_UP],
	"bgs_down": [JOY_BUTTON_DPAD_DOWN],
	"bgs_left": [JOY_BUTTON_DPAD_LEFT],
	"bgs_right": [JOY_BUTTON_DPAD_RIGHT],
	"bgs_a": [JOY_BUTTON_A],
	"bgs_b": [JOY_BUTTON_B],
	"bgs_x": [JOY_BUTTON_X],
	"bgs_y": [JOY_BUTTON_Y],
	"bgs_z": [JOY_BUTTON_RIGHT_SHOULDER],
}

const general_axis = {
	"bgs_c": [JOY_AXIS_TRIGGER_RIGHT],
}

const p1_start:= "bgs_p1_start"
const p2_start:= "bgs_p2_start"
const insert_credit:= "bgs_insert_credit"

const p1_device:= 0
const p2_device:= 1
#endregion

#region Credits constants
const autoload_credits_name:= "BgsArcadeCabCredits"
const setting_required_credits:= "bgs_arcade_cab/credits/minimum_required_credits"
#endregion

#region Idle Quit constants

const autoload_idle_name:= "BgsArcadeCabIdleQuit"
const setting_idle_quit_timeout:= "bgs_arcade_cab/idle_quit/timeout"
const setting_idle_quit_enabled:= "bgs_arcade_cab/idle_quit/enabled"
#endregion


func _enter_tree():
	_setup_input()
	_setup_credits_autoload()
	_setup_idle_quit_autoload()


func _exit_tree():
	_cleanup_idle_quit_autoload()
	_cleanup_credits_autoload()
	_cleanup_input()

#region Plugin Setup

func _setup_input() -> void:
	# General controller button inputs
	for button in general_buttons.keys():
		var input_info = {
			"deadzone": 0.5,
			"events": [],
		}
		for btn in general_buttons[button]:
			var event = InputEventJoypadButton.new()
			event.button_index = btn
			event.device = -1
			input_info["events"].append(event)
		ProjectSettings.set_setting("input/%s" % button, input_info)
	# General axis inputs
	for axis in general_axis.keys():
		var input_info = {
			"deadzone": 0.5,
			"events": [],
		}
		for input in general_axis[axis]:
			var event = InputEventJoypadMotion.new()
			event.axis = input
			event.device = -1
			input_info["events"].append(event)
		ProjectSettings.set_setting("input/%s" % axis, input_info)
	
	# Start buttons
	var p1_start_event = InputEventJoypadButton.new()
	var p2_start_event = InputEventJoypadButton.new()
	p1_start_event.button_index = JOY_BUTTON_START
	p2_start_event.button_index = JOY_BUTTON_START
	p1_start_event.device = p1_device
	p2_start_event.device = p2_device
	var p1_start_input = {
		"deadzone": 0.5,
		"events": [p1_start_event],
	}
	var p2_start_input = {
		"deadzone": 0.5,
		"events": [p2_start_event]
	}
	ProjectSettings.set_setting("input/%s" % p1_start, p1_start_input)
	ProjectSettings.set_setting("input/%s" % p2_start, p2_start_input)
	
	# Coin op
	var insert_credit_event = InputEventJoypadButton.new()
	insert_credit_event.button_index = JOY_BUTTON_BACK
	insert_credit_event.device = -1
	var insert_credit_event_debug = InputEventKey.new()
	insert_credit_event_debug.keycode = KEY_PLUS
	var insert_credit_input = {
		"deadzone": 0.5,
		"events": [insert_credit_event, insert_credit_event_debug]
	}
	ProjectSettings.set_setting("input/%s" % insert_credit, insert_credit_input)


func _setup_credits_autoload() -> void:
	add_autoload_singleton(autoload_credits_name, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_credits_autoload.gd")
	ProjectSettings.set(setting_required_credits, 1)
	var property_info = {
		"name": setting_required_credits,
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1,4,1,or_greater"
	}
	ProjectSettings.add_property_info(property_info)


func _setup_idle_quit_autoload() -> void:
	add_autoload_singleton(autoload_idle_name, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_idle_quit_autoload.gd")
	
	ProjectSettings.set(setting_idle_quit_enabled, true)
	var enabled_prop_info = {
		"name": setting_idle_quit_enabled,
		"type": TYPE_BOOL,
	}
	ProjectSettings.add_property_info(enabled_prop_info)
	
	ProjectSettings.set(setting_idle_quit_timeout, 30)
	var timeout_prop_info = {
		"name": setting_idle_quit_timeout,
		"type": TYPE_FLOAT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1,30,1,or_greater"
	}
	ProjectSettings.add_property_info(timeout_prop_info)

#endregion

#region Plugin Cleanup

func _cleanup_input() -> void:
	for input in general_buttons.keys():
		ProjectSettings.set_setting("input/%s" % input, null)
	ProjectSettings.set_setting("input/%s" % p1_start, null)
	ProjectSettings.set_setting("input/%s" % p2_start, null)
	ProjectSettings.set_setting("input/%s" % insert_credit, null)


func _cleanup_credits_autoload() -> void:
	if ProjectSettings.has_setting(setting_required_credits):
		ProjectSettings.set(setting_required_credits, null)
	remove_autoload_singleton(autoload_credits_name)


func _cleanup_idle_quit_autoload() -> void:
	if ProjectSettings.has_setting(setting_idle_quit_timeout):
		ProjectSettings.set(setting_idle_quit_timeout, null)
	remove_autoload_singleton(autoload_idle_name)

#endregion
