extends Node

## Emitted every time a credit is inserted
signal credit_added()
## Emitted whenever credits changes
signal credits_changed(current_credits)
## Emitted when enough credits have been entered to start a new game
signal enough_credits_added()
## Emitted when credits have been redeemed
signal credits_redeemed()

const setting_required_credits:= "bgs_arcade_cab/credits/minimum_required_credits"

## Currently available credits
var credits:= 0:
	set(value):
		credits = value
		credits_changed.emit(credits)
	get:
		return credits


func _ready() -> void:
	(func(): credits_changed.emit(credits)).call_deferred()


func _input(event):
	if event.is_action_pressed("bgs_insert_credit"):
		credits += 1
		if credits >= ProjectSettings.get_setting(setting_required_credits):
			enough_credits_added.emit()


func redeem_credits():
	var min_credits = ProjectSettings.get_setting(setting_required_credits)
	if credits >= min_credits:
		credits -= min_credits
		credits_redeemed.emit()
