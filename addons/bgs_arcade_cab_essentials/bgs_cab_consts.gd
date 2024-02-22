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


class AutoloadNames:
	const credits:= "BgsArcadeCabCredits"
	const idle_quit:= "BgsArcadeCabIdleQuit"
	const general_config:= "BgsGeneralConfig"
