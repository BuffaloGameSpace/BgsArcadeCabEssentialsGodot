extends Timer

var enabled: bool


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
