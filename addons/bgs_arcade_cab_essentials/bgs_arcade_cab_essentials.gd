@tool
extends EditorPlugin


#region Player Input
const default_action_set:PlayerInputActionSet = preload("res://addons/bgs_arcade_cab_essentials/resources/player_input/action_sets/default_action_set.tres")
#endregion

#region Bottom Panel
const main_ui := preload("res://addons/bgs_arcade_cab_essentials/ui/main_ui.tscn")
const main_ui_button_label:= "BGS Arcade Options"
var _main_ui_instance
var _main_ui_shown:= false
#endregion


func _enter_tree():
	_setup_credits_autoload()
	_setup_idle_quit_autoload()
	_setup_general_autoload()
	_setup_ui()
	pass


func _exit_tree():
	_cleanup_ui()
	_cleanup_general_autoload()
	_cleanup_idle_quit_autoload()
	_cleanup_credits_autoload()


func _enable_plugin():
	_setup_input_settings()
	_setup_general_settings()
	_setup_credits_settings()
	_setup_idle_quit_settings()


func _disable_plugin():
	_cleanup_idle_quit_settings()
	_cleanup_credits_settings()
	_cleanup_general_settings()
	_cleanup_input_settings()



#region Plugin Setup

func _setup_input_settings() -> void:
	for action in default_action_set.actions:
		if ProjectSettings.has_setting("input/%s" % action.name):
			printerr("Action %s already in ProjectSettings!" % action.name)
		var action_info = {
			"deadzone": 0.5,
			"events": []
		}
		action_info["events"].append_array(action.joy_button_events)
		action_info["events"].append_array(action.joy_motion_events)
		action_info["events"].append_array(action.key_events)
		ProjectSettings.set_setting("input/%s" % action.name, action_info)
	ProjectSettings.save()


func _setup_credits_autoload() -> void:
	add_autoload_singleton(BgsCabConsts.AutoloadNames.credits, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_credits_autoload.gd")	


func _setup_credits_settings() -> void:
	if !ProjectSettings.has_setting(BgsCabConsts.Settings.Credits.minimum_credits):
		ProjectSettings.set(BgsCabConsts.Settings.Credits.minimum_credits, 1)
		var required_credits_property_info = {
			"name": BgsCabConsts.Settings.Credits.minimum_credits,
			"type": TYPE_INT,
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "1,4,1,or_greater"
		}
		ProjectSettings.add_property_info(required_credits_property_info)
		ProjectSettings.save()
	
	if !ProjectSettings.has_setting(BgsCabConsts.Settings.Credits.free_play_enabled):
		ProjectSettings.set(BgsCabConsts.Settings.Credits.free_play_enabled, false)
		var free_play_property_info = {
			"name": BgsCabConsts.Settings.Credits.free_play_enabled,
			"type": TYPE_BOOL,
		}
		ProjectSettings.add_property_info(free_play_property_info)
		ProjectSettings.save()


func _setup_idle_quit_autoload() -> void:
	add_autoload_singleton(BgsCabConsts.AutoloadNames.idle_quit, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_idle_quit_autoload.gd")


func _setup_idle_quit_settings() -> void:
	if !ProjectSettings.has_setting(BgsCabConsts.Settings.IdleQuit.enabled):
		ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.enabled, true)
		var enabled_prop_info = {
			"name": BgsCabConsts.Settings.IdleQuit.enabled,
			"type": TYPE_BOOL,
		}
		ProjectSettings.add_property_info(enabled_prop_info)
		ProjectSettings.save()
	
	if !ProjectSettings.has_setting(BgsCabConsts.Settings.IdleQuit.timeout):
		ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.timeout, 30)
		var timeout_prop_info = {
			"name": BgsCabConsts.Settings.IdleQuit.timeout,
			"type": TYPE_FLOAT,
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "1,30,1,or_greater"
		}
		ProjectSettings.add_property_info(timeout_prop_info)
		ProjectSettings.save()


func _setup_general_autoload() -> void:
	add_autoload_singleton(BgsCabConsts.AutoloadNames.general_config, "res://addons/bgs_arcade_cab_essentials/autoloads/bgs_general_autoload.gd")


func _setup_general_settings() -> void:
	if !ProjectSettings.has_setting(BgsCabConsts.Settings.General.hide_cursor):
		ProjectSettings.set(BgsCabConsts.Settings.General.hide_cursor, true)
		var hide_cursor_prop_info = {
			"name": BgsCabConsts.Settings.General.hide_cursor,
			"type": TYPE_BOOL,
		}
		ProjectSettings.add_property_info(hide_cursor_prop_info)
		ProjectSettings.save()
	
	if !ProjectSettings.has_setting(BgsCabConsts.Settings.General.force_fullscreen):
		ProjectSettings.set(BgsCabConsts.Settings.General.force_fullscreen, true)
		var force_fullscreen_prop_info = {
			"name": BgsCabConsts.Settings.General.force_fullscreen,
			"type": TYPE_BOOL
		}
		ProjectSettings.add_property_info(force_fullscreen_prop_info)
		ProjectSettings.save()


func _setup_ui() -> void:
	_main_ui_instance = main_ui.instantiate()
	var main_ui_button = add_control_to_bottom_panel(_main_ui_instance, main_ui_button_label)
	main_ui_button.toggled.connect(_on_main_ui_toggled)
#endregion

#region Plugin Cleanup

func _cleanup_input_settings() -> void:
	for action in default_action_set.actions:
		ProjectSettings.set("input/%s" % action.name, null)
	ProjectSettings.save()


func _cleanup_credits_autoload() -> void:
	remove_autoload_singleton(BgsCabConsts.AutoloadNames.credits)


func _cleanup_credits_settings() -> void:
	if ProjectSettings.has_setting(BgsCabConsts.Settings.Credits.minimum_credits):
		ProjectSettings.set(BgsCabConsts.Settings.Credits.minimum_credits, null)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.Credits.free_play_enabled):
		ProjectSettings.set(BgsCabConsts.Settings.Credits.free_play_enabled, null)
	ProjectSettings.save()


func _cleanup_idle_quit_autoload() -> void:
	remove_autoload_singleton(BgsCabConsts.AutoloadNames.idle_quit)


func _cleanup_idle_quit_settings() -> void:
	if ProjectSettings.has_setting(BgsCabConsts.Settings.IdleQuit.timeout):
		ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.timeout, null)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.IdleQuit.enabled):
		ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.enabled, null)


func _cleanup_general_autoload() -> void:
	remove_autoload_singleton(BgsCabConsts.AutoloadNames.general_config)


func _cleanup_general_settings() -> void:
	if ProjectSettings.has_setting(BgsCabConsts.Settings.General.hide_cursor):
		ProjectSettings.set(BgsCabConsts.Settings.General.hide_cursor, null)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.General.force_fullscreen):
		ProjectSettings.set(BgsCabConsts.Settings.General.force_fullscreen, null)


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
