extends Label


func _process(_delta):
	text = "%02d" % (BgsArcadeCabIdleQuit.time_left as int)
