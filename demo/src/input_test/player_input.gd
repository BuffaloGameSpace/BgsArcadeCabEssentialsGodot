extends Control

@export_range(1, 2) var player:= 1

@export_group("Controls")
@export var stick:CabStick
@export var buttons:Array[CabButton]


func _ready():
	stick.player = player
	for button in buttons:
		button.player = player
