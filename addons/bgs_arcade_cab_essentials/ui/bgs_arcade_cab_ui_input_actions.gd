@tool
extends Control

@export var add_action_window:Window
@export var input_action_tree:Tree

var _action_tree_root:TreeItem


func _ready() -> void:
	_setup_action_tree()


func _setup_action_tree() -> void:
	_action_tree_root = input_action_tree.create_item()
	
	

func _show_add_action_window(input_button) -> void:
	pass


func _add_action(action_name:String, controller:int, input_button:String) -> void:
	pass
