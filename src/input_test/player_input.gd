extends Control

@export var device_id:= 0

@export_group("Controls")
@export var stick:CabStick
@export var buttons:Array[CabButton]

func _ready():
	stick.device_id = device_id
	for button in buttons:
		button.device_id = device_id
