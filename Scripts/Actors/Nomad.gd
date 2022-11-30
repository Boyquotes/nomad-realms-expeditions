extends CardPlayer
class_name Nomad

export (PackedScene) var card_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_dashboard.hand = ["Test card 1", "Test card 2"]
	print("HIS")

func update() -> void:
	pass
