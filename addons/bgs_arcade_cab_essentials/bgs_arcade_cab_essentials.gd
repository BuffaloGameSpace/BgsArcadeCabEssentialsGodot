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
	for action in BgsCabConsts.PlayerInput.mappings:
		var input_info = {
			"deadzone": 0.5,
			"events": [],
		}
		var device = BgsCabConsts.PlayerInput.mappings[action][BgsCabConsts.PlayerInput.MappingKeys.device]
		# Joypad Buttons
		if BgsCabConsts.PlayerInput.mappings[action].has(BgsCabConsts.PlayerInput.MappingKeys.buttons):
			for button in BgsCabConsts.PlayerInput.mappings[action][BgsCabConsts.PlayerInput.MappingKeys.buttons]:
				var button_event = InputEventJoypadButton.new()
				button_event.button_index = button
				button_event.device = device
				input_info["events"].append(button_event)
		if BgsCabConsts.PlayerInput.mappings[action].has(BgsCabConsts.PlayerInput.MappingKeys.axis):
			for axis in BgsCabConsts.PlayerInput.mappings[action][BgsCabConsts.PlayerInput.MappingKeys.axis]:
				var axis_event = InputEventJoypadMotion.new()
				axis_event.axis = axis
				axis_event.device = device
				input_info["events"].append(axis_event)
		if BgsCabConsts.PlayerInput.mappings[action].has(BgsCabConsts.PlayerInput.MappingKeys.keys):
			for key in BgsCabConsts.PlayerInput.mappings[action][BgsCabConsts.PlayerInput.MappingKeys.keys]:
				var key_event = InputEventKey.new()
				key_event.key_label = key
				key_event.device = -1 # Keyboard events are always all keyboards (should only be one)
				input_info["events"].append(key_event)
		ProjectSettings.set("input/%s" % action, input_info)
	InputMap.load_from_project_settings()


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
	for action in BgsCabConsts.PlayerInput.mappings:
		ProjectSettings.set("input/%s" % action, null)
	InputMap.load_from_project_settings()


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
