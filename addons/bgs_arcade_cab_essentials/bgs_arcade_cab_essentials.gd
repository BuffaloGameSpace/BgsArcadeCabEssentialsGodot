@tool
extends EditorPlugin


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
	for button in BgsCabConsts.PlayerInput.general_buttons.keys():
		var input_info = {
			"deadzone": 0.5,
			"events": [],
		}
		for btn in BgsCabConsts.PlayerInput.general_buttons[button]:
			var event = InputEventJoypadButton.new()
			event.button_index = btn
			event.device = -1
			input_info["events"].append(event)
		ProjectSettings.set_setting("input/%s" % button, input_info)
	# General axis inputs
	for axis in BgsCabConsts.PlayerInput.general_axis.keys():
		var input_info = {
			"deadzone": 0.5,
			"events": [],
		}
		for input in BgsCabConsts.PlayerInput.general_axis[axis]:
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
	p1_start_event.device = BgsCabConsts.PlayerInput.p1_device
	p2_start_event.device = BgsCabConsts.PlayerInput.p2_device
	var p1_start_input = {
		"deadzone": 0.5,
		"events": [p1_start_event],
	}
	var p2_start_input = {
		"deadzone": 0.5,
		"events": [p2_start_event]
	}
	ProjectSettings.set_setting("input/%s" % BgsCabConsts.PlayerInput.p1_start, p1_start_input)
	ProjectSettings.set_setting("input/%s" % BgsCabConsts.PlayerInput.p2_start, p2_start_input)
	
	# Coin op
	var p1_insert_credit_event = InputEventJoypadButton.new()
	p1_insert_credit_event.button_index = JOY_BUTTON_BACK
	p1_insert_credit_event.device = BgsCabConsts.PlayerInput.p1_device
	var p1_insert_credit_event_debug = InputEventKey.new()
	p1_insert_credit_event_debug.keycode = KEY_PLUS
	var p1_insert_credit_input = {
		"deadzone": 0.5,
		"events": [p1_insert_credit_event, p1_insert_credit_event_debug]
	}
	ProjectSettings.set_setting("input/%s" % BgsCabConsts.PlayerInput.p1_insert_credit, p1_insert_credit_input)
	
	var p2_insert_credit_event = InputEventJoypadButton.new()
	p2_insert_credit_event.button_index = JOY_BUTTON_BACK
	p2_insert_credit_event.device = BgsCabConsts.PlayerInput.p2_device
	var p2_insert_credit_event_debug = InputEventKey.new()
	p2_insert_credit_event_debug.keycode = KEY_INSERT
	var p2_insert_credit_input = {
		"deadzone": 0.5,
		"events": [p2_insert_credit_event, p2_insert_credit_event_debug]
	}
	ProjectSettings.set_setting("input/%s" % BgsCabConsts.PlayerInput.p2_insert_credit, p2_insert_credit_input)


func _setup_credits_autoload() -> void:
	ProjectSettings.set(BgsCabConsts.Settings.Credits.minimum_credits, 1)
	var required_credits_property_info = {
		"name": BgsCabConsts.Settings.Credits.minimum_credits,
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1,4,1,or_greater"
	}
	ProjectSettings.add_property_info(required_credits_property_info)
	
	ProjectSettings.set(BgsCabConsts.Settings.Credits.free_play_enabled, false)
	var free_play_property_info = {
		"name": BgsCabConsts.Settings.Credits.free_play_enabled,
		"type": TYPE_BOOL,
	}
	ProjectSettings.add_property_info(free_play_property_info)
	
	add_autoload_singleton(BgsCabConsts.AutoloadNames.credits, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_credits_autoload.gd")	


func _setup_idle_quit_autoload() -> void:
	ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.enabled, true)
	var enabled_prop_info = {
		"name": BgsCabConsts.Settings.IdleQuit.enabled,
		"type": TYPE_BOOL,
	}
	ProjectSettings.add_property_info(enabled_prop_info)
	
	ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.timeout, 30)
	var timeout_prop_info = {
		"name": BgsCabConsts.Settings.IdleQuit.timeout,
		"type": TYPE_FLOAT,
		"hint": PROPERTY_HINT_RANGE,
		"hint_string": "1,30,1,or_greater"
	}
	ProjectSettings.add_property_info(timeout_prop_info)
	
	add_autoload_singleton(BgsCabConsts.AutoloadNames.idle_quit, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_idle_quit_autoload.gd")


func _setup_general_autoload() -> void:
	ProjectSettings.set(BgsCabConsts.Settings.General.hide_cursor, true)
	var hide_cursor_prop_info = {
		"name": BgsCabConsts.Settings.General.hide_cursor,
		"type": TYPE_BOOL,
	}
	ProjectSettings.add_property_info(hide_cursor_prop_info)
	
	ProjectSettings.set(BgsCabConsts.Settings.General.force_fullscreen, true)
	var force_fullscreen_prop_info = {
		"name": BgsCabConsts.Settings.General.force_fullscreen,
		"type": TYPE_BOOL
	}
	ProjectSettings.add_property_info(force_fullscreen_prop_info)
	
	add_autoload_singleton(BgsCabConsts.AutoloadNames.general_config, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_general_autoload.gd")


func _setup_ui() -> void:
	_main_ui_instance = main_ui.instantiate()
	var main_ui_button = add_control_to_bottom_panel(_main_ui_instance, main_ui_button_label)
	main_ui_button.toggled.connect(_on_main_ui_toggled)
#endregion

#region Plugin Cleanup

func _cleanup_input() -> void:
	for input in BgsCabConsts.PlayerInput.general_buttons.keys():
		ProjectSettings.set_setting("input/%s" % input, null)
	for input in BgsCabConsts.PlayerInput.general_axis.keys():
		ProjectSettings.set_setting("input/%s" % input, null)
	ProjectSettings.set_setting("input/%s" % BgsCabConsts.PlayerInput.p1_start, null)
	ProjectSettings.set_setting("input/%s" % BgsCabConsts.PlayerInput.p2_start, null)
	ProjectSettings.set_setting("input/%s" % BgsCabConsts.PlayerInput.p1_insert_credit, null)
	ProjectSettings.set_setting("input/%s" % BgsCabConsts.PlayerInput.p2_insert_credit, null)

func _cleanup_credits_autoload() -> void:
	if ProjectSettings.has_setting(BgsCabConsts.Settings.Credits.minimum_credits):
		ProjectSettings.set(BgsCabConsts.Settings.Credits.minimum_credits, null)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.Credits.free_play_enabled):
		ProjectSettings.set(BgsCabConsts.Settings.Credits.free_play_enabled, null)
	remove_autoload_singleton(BgsCabConsts.AutoloadNames.credits)


func _cleanup_idle_quit_autoload() -> void:
	if ProjectSettings.has_setting(BgsCabConsts.Settings.IdleQuit.timeout):
		ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.timeout, null)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.IdleQuit.enabled):
		ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.enabled, null)
	remove_autoload_singleton(BgsCabConsts.AutoloadNames.idle_quit)


func _cleanup_general_autoload() -> void:
	if ProjectSettings.has_setting(BgsCabConsts.Settings.General.hide_cursor):
		ProjectSettings.set(BgsCabConsts.Settings.General.hide_cursor, null)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.General.force_fullscreen):
		ProjectSettings.set(BgsCabConsts.Settings.General.force_fullscreen, null)
	remove_autoload_singleton(BgsCabConsts.AutoloadNames.general_config)


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
