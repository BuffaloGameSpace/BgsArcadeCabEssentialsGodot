extends Node


func _ready() -> void:
	_configure_cursor()
	_configure_window()


func _configure_cursor() -> void:
	if ProjectSettings.get(BgsCabConsts.Settings.General.hide_cursor):
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN


func _configure_window() -> void:
	if ProjectSettings.get(BgsCabConsts.Settings.General.force_fullscreen):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
