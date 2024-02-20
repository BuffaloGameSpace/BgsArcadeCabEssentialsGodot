@tool
extends Control

@export var add_action_window:Window
@export var input_action_tree:Tree

var _action_tree_root:TreeItem
var _up_root:TreeItem
var _left_root:TreeItem
var _right_root:TreeItem
var _down_root:TreeItem
var _a_root:TreeItem
var _b_root:TreeItem
var _c_root:TreeItem
var _x_root:TreeItem
var _y_root:TreeItem
var _z_root:TreeItem
var _start_root:TreeItem
var _insert_credit_root:TreeItem


func _ready() -> void:
	_setup_action_tree()


func _setup_action_tree() -> void:
	_action_tree_root = input_action_tree.create_item()
	

func _show_add_action_window(input_button) -> void:
	pass


func _add_action(action_name:String, controller:int, input_button:String) -> void:
	pass
