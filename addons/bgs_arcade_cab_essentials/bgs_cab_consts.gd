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
	class Devices:
		const p1:= 0
		const p2:= 1
	
	class InputActions:
		const up:= "bgs_up"
		const down:= "bgs_down"
		const left:= "bgs_left"
		const right:= "bgs_right"
		const start:= "bgs_start"
		const insert_credit:= "bgs_insert_credit"
		const btn_a:= "bgs_btn_a"
		const btn_b:= "bgs_btn_b"
		const btn_c:= "bgs_btn_c"
		const btn_x:= "bgs_btn_x"
		const btn_y:= "bgs_btn_y"
		const btn_z:= "bgs_btn_z"
	
	class MappingKeys:
		const buttons:= "buttons"
		const axis:= "axis"
		const keys:= "keys"
		const device:= "device"
		
	const mappings = {
		#region Player 1 Mappings
		InputActions.up + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_DPAD_UP],
			MappingKeys.keys: [KEY_W],
			MappingKeys.device: 0
		},
		InputActions.down + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_DPAD_DOWN],
			MappingKeys.keys: [KEY_S],
			MappingKeys.device: 0
		},
		InputActions.left + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_DPAD_LEFT],
			MappingKeys.keys: [KEY_A],
			MappingKeys.device: 0
		},
		InputActions.right + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_DPAD_RIGHT],
			MappingKeys.keys: [KEY_D],
			MappingKeys.device: 0
		},
		InputActions.btn_a + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_A],
			MappingKeys.keys: [KEY_J],
			MappingKeys.device: 0
		},
		InputActions.btn_b + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_B],
			MappingKeys.keys: [KEY_K],
			MappingKeys.device: 0
		},
		InputActions.btn_c + "_p1": {
			MappingKeys.axis: [JOY_AXIS_TRIGGER_RIGHT],
			MappingKeys.keys: [KEY_L],
			MappingKeys.device: 0
		},
		InputActions.btn_x + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_X],
			MappingKeys.keys: [KEY_U],
			MappingKeys.device: 0
		},
		InputActions.btn_y + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_Y],
			MappingKeys.keys: [KEY_I],
			MappingKeys.device: 0
		},
		InputActions.btn_z + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_RIGHT_SHOULDER],
			MappingKeys.keys: [KEY_O],
			MappingKeys.device: 0
		},
		InputActions.start + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_START],
			MappingKeys.keys: [KEY_ENTER],
			MappingKeys.device: 0
		},
		InputActions.insert_credit + "_p1": {
			MappingKeys.buttons: [JOY_BUTTON_BACK],
			MappingKeys.keys: [KEY_INSERT],
			MappingKeys.device: 0
		},
		#endregion
		#region Player 2 Mappings
		InputActions.up + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_DPAD_UP],
			MappingKeys.keys: [KEY_UP],
			MappingKeys.device: 1
		},
		InputActions.down + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_DPAD_DOWN],
			MappingKeys.keys: [KEY_DOWN],
			MappingKeys.device: 1
		},
		InputActions.left + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_DPAD_LEFT],
			MappingKeys.keys: [KEY_LEFT],
			MappingKeys.device: 1
		},
		InputActions.right + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_DPAD_RIGHT],
			MappingKeys.keys: [KEY_RIGHT],
			MappingKeys.device: 1
		},
		InputActions.btn_a + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_A],
			MappingKeys.keys: [KEY_KP_1],
			MappingKeys.device: 1
		},
		InputActions.btn_b + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_B],
			MappingKeys.keys: [KEY_KP_2],
			MappingKeys.device: 1
		},
		InputActions.btn_c + "_p2": {
			MappingKeys.axis: [JOY_AXIS_TRIGGER_RIGHT],
			MappingKeys.keys: [KEY_KP_3],
			MappingKeys.device: 1
		},
		InputActions.btn_x + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_X],
			MappingKeys.keys: [KEY_KP_4],
			MappingKeys.device: 1
		},
		InputActions.btn_y + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_Y],
			MappingKeys.keys: [KEY_KP_5],
			MappingKeys.device: 1
		},
		InputActions.btn_z + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_RIGHT_SHOULDER],
			MappingKeys.keys: [KEY_KP_6],
			MappingKeys.device: 1
		},
		InputActions.start + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_START],
			MappingKeys.keys: [KEY_KP_ENTER],
			MappingKeys.device: 1
		},
		InputActions.insert_credit + "_p2": {
			MappingKeys.buttons: [JOY_BUTTON_BACK],
			MappingKeys.keys: [KEY_KP_ADD],
			MappingKeys.device: 1
		},
		#endregion
	}
	
	const general_button_mappings = {
		InputActions.up: [JOY_BUTTON_DPAD_UP],
		InputActions.down: [JOY_BUTTON_DPAD_DOWN],
		InputActions.left: [JOY_BUTTON_DPAD_LEFT],
		InputActions.right: [JOY_BUTTON_DPAD_RIGHT],
		InputActions.btn_a: [JOY_BUTTON_A],
		InputActions.btn_b: [JOY_BUTTON_B],
		InputActions.btn_x: [JOY_BUTTON_X],
		InputActions.btn_y: [JOY_BUTTON_Y],
		InputActions.btn_z: [JOY_BUTTON_RIGHT_SHOULDER],
		
	}
	const general_axis_mappings = {
		InputActions.btn_c: [JOY_AXIS_TRIGGER_RIGHT],
	}


class AutoloadNames:
	const credits:= "BgsArcadeCabCredits"
	const idle_quit:= "BgsArcadeCabIdleQuit"
	const general_config:= "BgsGeneralConfig"
