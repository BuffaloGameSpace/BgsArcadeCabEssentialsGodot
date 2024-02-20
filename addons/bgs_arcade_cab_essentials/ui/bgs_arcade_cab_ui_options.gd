@tool
extends Control


#region General
@export var launch_fullscreen:CheckBox
@export var hide_cursor:CheckBox
#endregion

#region Credits
@export var min_credits:SpinBox
@export var free_play:CheckBox
#endregion

#region Idle Quit
@export var idle_quit_enabled:CheckBox
@export var idle_quit_timeout:SpinBox
#endregion


func _ready():
	ProjectSettings.settings_changed.connect(_on_project_settings_changed)


func _on_project_settings_changed() -> void:
	if ProjectSettings.has_setting(BgsCabConsts.Settings.General.force_fullscreen):
		launch_fullscreen.button_pressed = ProjectSettings.get(BgsCabConsts.Settings.General.force_fullscreen)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.General.hide_cursor):
		hide_cursor.button_pressed = ProjectSettings.get(BgsCabConsts.Settings.General.hide_cursor)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.Credits.minimum_credits):
		min_credits.value = ProjectSettings.get(BgsCabConsts.Settings.Credits.minimum_credits)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.Credits.free_play_enabled):
		free_play.button_pressed = ProjectSettings.get(BgsCabConsts.Settings.Credits.free_play_enabled)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.IdleQuit.enabled):
		idle_quit_enabled.button_pressed = ProjectSettings.get(BgsCabConsts.Settings.IdleQuit.enabled)
	if ProjectSettings.has_setting(BgsCabConsts.Settings.IdleQuit.timeout):
		idle_quit_timeout.value = ProjectSettings.get(BgsCabConsts.Settings.IdleQuit.timeout)


func _on_launch_fullscreen_check_box_toggled(toggled_on:bool):
	ProjectSettings.set(BgsCabConsts.Settings.General.force_fullscreen, toggled_on)
	ProjectSettings.save()


func _on_hide_cursor_check_box_toggled(toggled_on:bool):
	ProjectSettings.set(BgsCabConsts.Settings.General.hide_cursor, toggled_on)
	ProjectSettings.save()


func _on_minimum_credits_spin_box_value_changed(value):
	ProjectSettings.set(BgsCabConsts.Settings.Credits.minimum_credits, value as int)
	ProjectSettings.save()


func _on_free_play_check_box_toggled(toggled_on:bool):
	ProjectSettings.set(BgsCabConsts.Settings.Credits.free_play_enabled, toggled_on)
	ProjectSettings.save()


func _on_idle_timer_check_box_toggled(toggled_on:bool):
	ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.enabled, toggled_on)
	ProjectSettings.save()


func _on_idle_timeout_spin_box_value_changed(value):
	ProjectSettings.set(BgsCabConsts.Settings.IdleQuit.timeout, value as int)
	ProjectSettings.save()
