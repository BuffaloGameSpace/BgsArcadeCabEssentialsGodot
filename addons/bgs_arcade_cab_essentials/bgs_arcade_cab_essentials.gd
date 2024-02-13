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

const p1_device:= 0
const p2_device:= 1

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
		var input_info = {
			"deadzone": 0.5,
			"events": [],
		}
		for btn in general_inputs[input]:
			var event = InputEventJoypadButton.new()
			event.button_index = btn
			event.device = -1
			input_info["events"].append(event)
		ProjectSettings.set_setting("input/%s" % input, input_info)
	
	# Start buttons
	var p1_start_event = InputEventJoypadButton.new()
	var p2_start_event = InputEventJoypadButton.new()
	p1_start_event.button_index = JOY_BUTTON_START
	p2_start_event.button_index = JOY_BUTTON_START
	p1_start_event.device = p1_device
	p2_start_event.device = p2_device
	var p1_start_input = {
		"deadzone": 0.5,
		"events": [p1_start_event],
	}
	var p2_start_input = {
		"deadzone": 0.5,
		"events": [p2_start_event]
	}
	ProjectSettings.set_setting("input/%s" % p1_start, p1_start_input)
	ProjectSettings.set_setting("input/%s" % p2_start, p2_start_input)
	
	# Coin op
	var insert_credit_event = InputEventJoypadButton.new()
	insert_credit_event.button_index = JOY_BUTTON_BACK
	insert_credit_event.device = -1
	var insert_credit_event_debug = InputEventKey.new()
	insert_credit_event_debug.keycode = KEY_PLUS
	var insert_credit_input = {
		"deadzone": 0.5,
		"events": [insert_credit_event, insert_credit_event_debug]
	}
	ProjectSettings.set_setting("input/%s" % insert_credit, insert_credit_input)


func _setup_credits_autoload() -> void:
	pass


func _setup_idle_quit_autoload() -> void:
	pass


func _cleanup_input() -> void:
	for input in general_inputs.keys():
		ProjectSettings.set_setting("input/%s" % input, null)
	ProjectSettings.set_setting("input/%s" % p1_start, null)
	ProjectSettings.set_setting("input/%s" % p2_start, null)
	ProjectSettings.set_setting("input/%s" % insert_credit, null)


func _cleanup_credits_autoload() -> void:
	pass


func _cleanup_idle_quit_autoload() -> void:
	pass
