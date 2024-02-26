class_name CabStick
extends TextureRect

@export_range(1, 2) var player:= 1

var _sprites = {
	Vector2i(0, 0): preload("res://addons/bgs_cab_essentials/assets/sprites/inputs/Stick Center.svg"),
	Vector2i(1, 0): preload("res://addons/bgs_cab_essentials/assets/sprites/inputs/Stick Right.svg"),
	Vector2i(1, -1): preload("res://addons/bgs_cab_essentials/assets/sprites/inputs/Stick Up Right.svg"),
	Vector2i(0, -1): preload("res://addons/bgs_cab_essentials/assets/sprites/inputs/Stick Up.svg"),
	Vector2i(-1, -1): preload("res://addons/bgs_cab_essentials/assets/sprites/inputs/Stick Up Left.svg"),
	Vector2i(-1, 0): preload("res://addons/bgs_cab_essentials/assets/sprites/inputs/Stick Left.svg"),
	Vector2i(-1, 1): preload("res://addons/bgs_cab_essentials/assets/sprites/inputs/Stick Down Left.svg"),
	Vector2i(0, 1): preload("res://addons/bgs_cab_essentials/assets/sprites/inputs/Stick Down.svg"),
	Vector2i(1, 1): preload("res://addons/bgs_cab_essentials/assets/sprites/inputs/Stick Down Right.svg"),
}

var _pos: Vector2i


func _unhandled_input(event):
	if event.is_action_pressed("bgs_left_p%d" % player):
		_pos.x -= 1
	if event.is_action_released("bgs_left_p%d" % player):
		_pos.x += 1
	if event.is_action_pressed("bgs_right_p%d" % player):
		_pos.x += 1
	if event.is_action_released("bgs_right_p%d" % player):
		_pos.x -= 1
	if event.is_action_pressed("bgs_up_p%d" % player):
		_pos.y -= 1
	if event.is_action_released("bgs_up_p%d" % player):
		_pos.y += 1
	if event.is_action_pressed("bgs_down_p%d" % player):
		_pos.y += 1
	if event.is_action_released("bgs_down_p%d" % player):
		_pos.y -= 1
	
	if _sprites.has(_pos):
		texture = _sprites[_pos]

