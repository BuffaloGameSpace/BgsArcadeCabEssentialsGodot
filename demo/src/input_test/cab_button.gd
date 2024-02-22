class_name CabButton
extends TextureRect

@export_range(1, 2) var player:= 1
@export_enum(
	"bgs_a",
	"bgs_b",
	"bgs_c",
	"bgs_x",
	"bgs_y",
	"bgs_z",
	"bgs_start",
	"bgs_insert_credit",
) var action:String
@export var released_texture:CompressedTexture2D
@export var pressed_texture:CompressedTexture2D


func _unhandled_input(event):
	if event.is_action_pressed("%s_p%d" % [action, player]):
		texture = pressed_texture
	if event.is_action_released("%s_p%d" % [action, player]):
		texture = released_texture
