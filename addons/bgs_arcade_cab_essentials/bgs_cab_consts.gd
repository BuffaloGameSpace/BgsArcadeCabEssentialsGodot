class_name BgsCabConsts


class Settings:
	class General:
		const force_fullscreen:= "bgs_arcade_cab/general/force_fullscreen"
		const hide_cursor:= "bgs_arcade_cab/general/hide_cursor"
	
	class IdleQuit:
		const timeout:= "bgs_arcade_cab/idle_quit/timeout"
		const enabled:= "bgs_arcade_cab/idle_quit/enabled"
	
	class Credits:
		const minimum_credits:= "bgs_arcade_cab/credits/minimum_required_credits"
		const free_play_enabled:= "bgs_arcade_cab/credits/free_play_enabled"


class PlayerInput:
	const p1_device:= 0
	const p2_device:= 1
	
	const p1_start:= "bgs_p1_start"
	const p2_start:= "bgs_p2_start"
	
	const p1_insert_credit:= "bgs_p1_insert_credit"
	const p2_insert_credit:= "bgs_p2_insert_credit"
	
	const general_buttons = {
		"bgs_up": [JOY_BUTTON_DPAD_UP],
		"bgs_down": [JOY_BUTTON_DPAD_DOWN],
		"bgs_left": [JOY_BUTTON_DPAD_LEFT],
		"bgs_right": [JOY_BUTTON_DPAD_RIGHT],
		"bgs_a": [JOY_BUTTON_A],
		"bgs_b": [JOY_BUTTON_B],
		"bgs_x": [JOY_BUTTON_X],
		"bgs_y": [JOY_BUTTON_Y],
		"bgs_z": [JOY_BUTTON_RIGHT_SHOULDER],
	}
	const general_axis = {
		"bgs_c": [JOY_AXIS_TRIGGER_RIGHT],
	}


class AutoloadNames:
	const credits:= "BgsArcadeCabCredits"
	const idle_quit:= "BgsArcadeCabIdleQuit"
	const general_config:= "BgsGeneralConfig"
