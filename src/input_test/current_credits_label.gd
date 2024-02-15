extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	BgsArcadeCabCredits.credits_changed.connect(_on_credits_changed)


func _on_credits_changed(credits:int) -> void:
	text = "%d / %d" % [credits, ProjectSettings.get("bgs_arcade_cab/credits/minimum_required_credits")]
