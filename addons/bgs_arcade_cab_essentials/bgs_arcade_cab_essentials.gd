@tool
extends EditorPlugin

#region Input
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

#region Credits
const autoload_credits_name:= "BgsArcadeCabCredits"
const setting_required_credits:= "bgs_arcade_cab/credits/minimum_required_credits"
const setting_free_play_enabled:= "bgs_arcade_cab/credits/free_play_enabled"
#endregion

#region Idle Quit
const autoload_idle_name:= "BgsArcadeCabIdleQuit"
const setting_idle_quit_timeout:= "bgs_arcade_cab/idle_quit/timeout"
const setting_idle_quit_enabled:= "bgs_arcade_cab/idle_quit/enabled"
#endregion

#region General options
const autoload_general_name:= "BgsGeneralConfig"
const setting_general_hide_cursor:= "bgs_arcade_cab/general/hide_cursor"
const setting_general_force_fullscreen:= "bgs_arcade_cab/general/force_fullscreen"
#endregion

#region Bottom Panel
const main_ui := preload("res://addons/bgs_arcade_cab_essentials/ui/main_ui.tscn")
const main_ui_button_label:= "BGS Arcade Options"
var _main_ui_instance
var _main_ui_shown:= false
#endregion


func _enter_tree():
	_setup_input()
	_setup_credits_autoload()
	_setup_idle_quit_autoload()
	_setup_general_autoload()
	_setup_ui()


func _exit_tree():
	_cleanup_ui()
	_cleanup_general_autoload()
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
	ProjectSettings.set(setting_required_credits, 1)
	var required_credits_property_info = {
		"name": setting_required_credits,
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1,4,1,or_greater"
	}
	ProjectSettings.add_property_info(required_credits_property_info)
	
	ProjectSettings.set(setting_free_play_enabled, false)
	var free_play_property_info = {
		"name": setting_free_play_enabled,
		"type": TYPE_BOOL,
	}
	ProjectSettings.add_property_info(free_play_property_info)
	
	add_autoload_singleton(autoload_credits_name, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_credits_autoload.gd")	


func _setup_idle_quit_autoload() -> void:
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
	
	add_autoload_singleton(autoload_idle_name, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_idle_quit_autoload.gd")


func _setup_general_autoload() -> void:
	ProjectSettings.set(setting_general_hide_cursor, true)
	var hide_cursor_prop_info = {
		"name": setting_general_hide_cursor,
		"type": TYPE_BOOL,
	}
	ProjectSettings.add_property_info(hide_cursor_prop_info)
	
	ProjectSettings.set(setting_general_force_fullscreen, true)
	var force_fullscreen_prop_info = {
		"name": setting_general_force_fullscreen,
		"type": TYPE_BOOL
	}
	ProjectSettings.add_property_info(force_fullscreen_prop_info)
	
	add_autoload_singleton(autoload_general_name, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_general_autoload.gd")



func _setup_ui() -> void:
	_main_ui_instance = main_ui.instantiate()
	var main_ui_button = add_control_to_bottom_panel(_main_ui_instance, main_ui_button_label)
	main_ui_button.toggled.connect(_on_main_ui_toggled)
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
	if ProjectSettings.has_setting(setting_free_play_enabled):
		ProjectSettings.set(setting_free_play_enabled, null)
	remove_autoload_singleton(autoload_credits_name)


func _cleanup_idle_quit_autoload() -> void:
	if ProjectSettings.has_setting(setting_idle_quit_timeout):
		ProjectSettings.set(setting_idle_quit_timeout, null)
	remove_autoload_singleton(autoload_idle_name)


func _cleanup_general_autoload() -> void:
	if ProjectSettings.has_setting(setting_general_hide_cursor):
		ProjectSettings.set(setting_general_hide_cursor, null)
	if ProjectSettings.has_setting(setting_general_force_fullscreen):
		ProjectSettings.set(setting_general_force_fullscreen, null)
	remove_autoload_singleton(autoload_general_name)


func _cleanup_ui() -> void:
	if _main_ui_instance:
		remove_control_from_bottom_panel(_main_ui_instance)
		_main_ui_instance.queue_free()

#endregion


func _on_main_ui_toggled(toggled:bool) -> void:
	if toggled:
		make_bottom_panel_item_visible(_main_ui_instance)
	else:
		hide_bottom_panel()
