extends HBoxContainer


func _unhandled_input(event):
	if event.is_action_pressed("bgs_start_p1") || event.is_action_pressed("bgs_start_p2"):
		BgsCabCredits.redeem_credits()
