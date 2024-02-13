class_name CabStick
extends TextureRect

@export var device_id:= 0

var _sprites = {
	Vector2i(0, 0): preload("res://assets/sprites/inputs/Stick Center.svg"),
	Vector2i(1, 0): preload("res://assets/sprites/inputs/Stick Right.svg"),
	Vector2i(1, -1): preload("res://assets/sprites/inputs/Stick Up Right.svg"),
	Vector2i(0, -1): preload("res://assets/sprites/inputs/Stick Up.svg"),
	Vector2i(-1, -1): preload("res://assets/sprites/inputs/Stick Up Left.svg"),
	Vector2i(-1, 0): preload("res://assets/sprites/inputs/Stick Left.svg"),
	Vector2i(-1, 1): preload("res://assets/sprites/inputs/Stick Down Left.svg"),
	Vector2i(0, 1): preload("res://assets/sprites/inputs/Stick Down.svg"),
	Vector2i(1, 1): preload("res://assets/sprites/inputs/Stick Down Right.svg"),
}

var _pos: Vector2i


func _input(event):
	if event.device == device_id:
		if event.is_action_pressed("bgs_stick_left"):
			_pos.x -= 1
		if event.is_action_released("bgs_stick_left"):
			_pos.x += 1
		if event.is_action_pressed("bgs_stick_right"):
			_pos.x += 1
		if event.is_action_released("bgs_stick_right"):
			_pos.x -= 1
		if event.is_action_pressed("bgs_stick_up"):
			_pos.y -= 1
		if event.is_action_released("bgs_stick_up"):
			_pos.y += 1
		if event.is_action_pressed("bgs_stick_down"):
			_pos.y += 1
		if event.is_action_released("bgs_stick_down"):
			_pos.y -= 1
		
		if _sprites.has(_pos):
			texture = _sprites[_pos]

