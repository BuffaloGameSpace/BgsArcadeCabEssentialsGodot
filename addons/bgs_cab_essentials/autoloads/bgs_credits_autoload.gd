extends Node

## A helper autoload for tracking game credits.
##
## The BGS Arcade Cab has two coin slots, which are mapped to button inputs.
## Using this autoload, you can keep track of the number of credits inserted
## while your game is running and utilize the signals to notify other nodes
## when credits have been added, when enough credits have been added to start or 
## continue the game, and more. It additionally has a helper method for
## redeeming credits safely.
##
## Credits required and free play functionality can be configured via "BGS Arcade
## Options > Credits" or within "Project Settings > Bgs Arcade Cab > Credits".


## Emitted every time a credit is inserted
signal credit_added()
## Emitted whenever credits changes
signal credits_changed(current_credits)
## Emitted when enough credits have been entered to start a new game
signal enough_credits_added()
## Emitted when a credit has been inserted but free play is enabled
signal free_play_credit_added()
## Emitted when credits have been redeemed
signal credits_redeemed()

## Currently available credits
var credits:= 0:
	set(value):
		credits = value
		if credits < 0:
			credits = 0
		credits_changed.emit(credits)
	get:
		return credits

## Toggled whether or not credits need to be added to be redeemed. Also enables
## emission of [signal free_play_credit_added] when credits are inserted and
## [member free_play_enabled] is true. 
@onready var free_play_enabled:bool = ProjectSettings.get(BgsCabConsts.Settings.Credits.free_play_enabled)


func _ready() -> void:
	(func(): credits_changed.emit(credits)).call_deferred()


func _unhandled_input(event):
	if event.is_action_pressed("bgs_insert_credit_p1") || event.is_action_pressed("bgs_insert_credit_p2"):
		credits += 1
		if free_play_enabled:
			free_play_credit_added.emit()
		if credits >= ProjectSettings.get_setting(BgsCabConsts.Settings.Credits.minimum_credits):
			enough_credits_added.emit()

## Use this to redeem credits. It ensures that credits are subtracted from the
## available credits only if enough have been added (Minimum Credits), and emits
## [signal credits_redeemed] when successful.
func redeem_credits():
	var min_credits = ProjectSettings.get_setting(BgsCabConsts.Settings.Credits.minimum_credits)
	if free_play_enabled || credits >= min_credits:
		credits -= min_credits
		credits_redeemed.emit()
