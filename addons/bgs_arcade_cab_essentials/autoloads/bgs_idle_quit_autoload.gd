extends Timer

var enabled: bool


func _ready() -> void:
	wait_time = ProjectSettings.get(BgsCabConsts.Settings.IdleQuit.timeout)
	enabled = ProjectSettings.get(BgsCabConsts.Settings.IdleQuit.enabled)
	timeout.connect(_on_timeout)
	if enabled:
		start(wait_time)


func _input(event):
	if enabled:
		if event is InputEventJoypadButton || event is InputEventJoypadMotion:
			start(wait_time)


func _on_timeout() -> void:
	get_tree().quit()
