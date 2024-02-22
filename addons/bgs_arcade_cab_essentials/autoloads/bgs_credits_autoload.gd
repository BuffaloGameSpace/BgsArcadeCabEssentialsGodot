extends Node

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

@onready var free_play_enabled:= ProjectSettings.get(BgsCabConsts.Settings.Credits.free_play_enabled)

func _ready() -> void:
	(func(): credits_changed.emit(credits)).call_deferred()


func _unhandled_input(event):
	if event.is_action_pressed("bgs_insert_credit_p1") || event.is_action_pressed("bgs_insert_credit_p2"):
		credits += 1
		if free_play_enabled:
			free_play_credit_added.emit()
		if credits >= ProjectSettings.get_setting(BgsCabConsts.Settings.Credits.minimum_credits):
			enough_credits_added.emit()


func redeem_credits():
	var min_credits = ProjectSettings.get_setting(BgsCabConsts.Settings.Credits.minimum_credits)
	if free_play_enabled || credits >= min_credits:
		credits -= min_credits
		credits_redeemed.emit()
