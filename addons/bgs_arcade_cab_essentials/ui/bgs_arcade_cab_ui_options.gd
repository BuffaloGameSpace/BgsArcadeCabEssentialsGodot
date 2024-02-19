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
	# Fire once to ensure settings match at plugin start
	_on_project_settings_changed()

func _on_project_settings_changed() -> void:
	launch_fullscreen.button_pressed = ProjectSettings.get("bgs_arcade_cab/general/force_fullscreen")
	hide_cursor.button_pressed = ProjectSettings.get("bgs_arcade_cab/general/hide_cursor")
	min_credits.value = ProjectSettings.get("bgs_arcade_cab/credits/minimum_required_credits")
	free_play.button_pressed = ProjectSettings.get("bgs_arcade_cab/credits/free_play_enabled")
	idle_quit_enabled.button_pressed = ProjectSettings.get("bgs_arcade_cab/idle_quit/enabled")
	idle_quit_timeout.value = ProjectSettings.get("bgs_arcade_cab/idle_quit/timeout")

func _on_launch_fullscreen_check_box_toggled(toggled_on:bool):
	if toggled_on:
		ProjectSettings.set("display/window/size/mode", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		ProjectSettings.set("display/window/size/mode", DisplayServer.WINDOW_MODE_WINDOWED)


func _on_hide_cursor_check_box_toggled(toggled_on:bool):
	ProjectSettings.set("bgs_arcade_cab/general/hide_cursor", toggled_on)


func _on_minimum_credits_spin_box_value_changed(value):
	ProjectSettings.set("bgs_arcade_cab/credits/minimum_required_credits", value as int)


func _on_free_play_check_box_toggled(toggled_on:bool):
	ProjectSettings.set("bgs_arcade_cab/credits/free_play_enabled", toggled_on)


func _on_idle_timer_check_box_toggled(toggled_on:bool):
	ProjectSettings.set("bgs_arcade_cab/idle_quit/enabled", toggled_on)


func _on_idle_timeout_spin_box_value_changed(value):
	ProjectSettings.set("bgs_arcade_cab/idle_quit/timeout", value as int)
