extends Label


func _ready() -> void:
	visible = false
	BgsCabCredits.enough_credits_added.connect(_on_enough_credits_added)
	BgsCabCredits.credits_redeemed.connect(_on_credits_redeemed)


func _on_enough_credits_added() -> void:
	visible = true


func _on_credits_redeemed() -> void:
	visible = false
