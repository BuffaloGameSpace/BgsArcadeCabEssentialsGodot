extends Timer


var enabled: bool

func _ready() -> void:
	wait_time = ProjectSettings.get("bgs_arcade_cab/idle_quit/timeout")
	enabled = ProjectSettings.get("bgs_arcade_cab/idle_quit/enabled")
	timeout.connect(_on_timeout)
	if enabled:
		start(wait_time)


func _input(event):
	if enabled:
		if event is InputEventJoypadButton || event is InputEventJoypadMotion:
			start(wait_time)


func _on_timeout() -> void:
	get_tree().quit()
