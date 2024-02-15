class_name CabButton
extends TextureRect

@export var device_id:= 0
@export_enum(
	"bgs_btn_a",
	"bgs_btn_b",
	"bgs_btn_c",
	"bgs_btn_x",
	"bgs_btn_y",
	"bgs_btn_z",
	"bgs_p1_start",
	"bgs_p2_start",
	) var action:String
@export var released_texture:CompressedTexture2D
@export var pressed_texture:CompressedTexture2D


func _input(event):
	if event.device == device_id:
		if event.is_action_pressed(action):
			texture = pressed_texture
		if event.is_action_released(action):
			texture = released_texture
