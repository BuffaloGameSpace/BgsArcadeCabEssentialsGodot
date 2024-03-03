extends Node

## General game settings.
##
## This autoload handles some general properties about the game, such as forcing
## fullscreen mode and hiding the mouse cursor. You can view and edit all options
## from either "BGS Arcade Options > Game Options" or "Project Settings > Bgs 
## Arcade Cab > General".
##
## Game Options:
## - Force Fullscreen: If enabled, the game will switch to fullscreen mode after
##   launching, ignoring any other options set.
## - Hide Cursor: If enabled, the mouse cursor will be hidden and confined to
##   the game screen.


func _ready() -> void:
	_configure_cursor()
	_configure_window()


func _configure_cursor() -> void:
	if ProjectSettings.get(BgsCabConsts.Settings.General.hide_cursor):
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN


func _configure_window() -> void:
	if ProjectSettings.get(BgsCabConsts.Settings.General.force_fullscreen):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
