extends Label


func _process(_delta):
	text = "%02d" % (BgsCabIdleQuit.time_left as int)
