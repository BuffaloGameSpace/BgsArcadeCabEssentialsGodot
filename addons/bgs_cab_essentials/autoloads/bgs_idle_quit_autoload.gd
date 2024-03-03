extends Timer

## Autoquits the application if no input actions are received.
##
## In order to prevent a game from taking over the cabinet entirely, this autoload
## starts a timer and monitors for any input activity. If an input event
## matches one in the Input Map, the timer is restarted. Otherwise, when the
## timer reaches 0, the application quits.
##
## The [member Timer.wait_time] can be set either in the BGS Arcade Options > Game Options
## menu or Project Settings under BGS Arcade Cab > Idle Quit > Timeout.
##
## You can disable the autoload from the above locations, or programmatically
## by setting [member enabled] to false.


## Flag to control whether the timer is running or not.
var enabled: bool:
	set(value):
		enabled = value
		if enabled:
			start(wait_time)
		else:
			stop()
	get:
		return enabled


func _ready() -> void:
	wait_time = ProjectSettings.get(BgsCabConsts.Settings.IdleQuit.timeout)
	enabled = ProjectSettings.get(BgsCabConsts.Settings.IdleQuit.enabled)
	timeout.connect(_on_timeout)
	if enabled:
		start(wait_time)


func _unhandled_input(event):
	if enabled:
		for action in InputMap.get_actions():
			if event.is_action(action):
				start(wait_time)
				break


func _on_timeout() -> void:
	get_tree().quit()
