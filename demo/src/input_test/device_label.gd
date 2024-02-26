extends Label

@export var device_id:= 0


func _ready() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)


func _on_joy_connection_changed(device:int, connected:bool) -> void:
	if device == device_id:
		text = "Device %d | %s | %s" % [device, Input.get_joy_name(device) if connected else "?", "connected" if connected else "disconnected"]
