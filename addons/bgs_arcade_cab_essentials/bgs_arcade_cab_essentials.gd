@tool
extends EditorPlugin


const general_inputs = {
	"bgs_stick_up": [JOY_BUTTON_DPAD_UP],
	"bgs_stick_down": [JOY_BUTTON_DPAD_DOWN],
	"bgs_stick_left": [JOY_BUTTON_DPAD_LEFT],
	"bgs_stick_right": [JOY_BUTTON_DPAD_RIGHT],
	"bgs_btn_a": [JOY_BUTTON_A],
	"bgs_btn_b": [JOY_BUTTON_B],
	"bgs_btn_c": [JOY_BUTTON_LEFT_SHOULDER],
	"bgs_btn_x": [JOY_BUTTON_X],
	"bgs_btn_y": [JOY_BUTTON_Y],
	"bgs_btn_z": [JOY_BUTTON_RIGHT_SHOULDER],
}

const p1_start:= "bgs_p1_start"
const p2_start:= "bgs_p2_start"
const insert_credit:= "bgs_insert_credit"

func _enter_tree():
	_setup_input()
	_setup_credits_autoload()
	_setup_idle_quit_autoload()


func _exit_tree():
	_cleanup_idle_quit_autoload()
	_cleanup_credits_autoload()
	_cleanup_input()



func _setup_input() -> void:
	# General controller inputs
	for input in general_inputs.keys():
		InputMap.add_action(input)
		for btn in general_inputs[input]:
			var event = InputEventJoypadButton.new()
			event.button_index = btn
			InputMap.action_add_event(input, event)
	
	# Start buttons
	InputMap.add_action(p1_start)
	InputMap.add_action(p2_start)
	var p1_start_event = InputEventJoypadButton.new()
	var p2_start_event = InputEventJoypadButton.new()
	p1_start_event.button_index = JOY_BUTTON_START
	p2_start_event.button_index = JOY_BUTTON_START
	p1_start_event.device = 0
	p2_start_event.device = 1
	InputMap.action_add_event(p1_start, p1_start_event)
	InputMap.action_add_event(p2_start, p2_start_event)
	
	# Coin op
	InputMap.add_action(insert_credit)
	var insert_credit_event = InputEventJoypadButton.new()
	insert_credit_event.button_index = JOY_BUTTON_BACK
	InputMap.action_add_event(insert_credit, insert_credit_event)
	var insert_credit_event_debug = InputEventKey.new()
	insert_credit_event_debug.keycode = KEY_PLUS
	InputMap.action_add_event(insert_credit, insert_credit_event_debug)


func _setup_credits_autoload() -> void:
	pass


func _setup_idle_quit_autoload() -> void:
	pass


func _cleanup_input() -> void:
	for input in general_inputs.keys():
		InputMap.erase_action(input)
	InputMap.erase_action(p1_start)
	InputMap.erase_action(p2_start)
	InputMap.erase_action(insert_credit)


func _cleanup_credits_autoload() -> void:
	pass


func _cleanup_idle_quit_autoload() -> void:
	pass
