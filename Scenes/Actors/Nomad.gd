extends CardPlayer
class_name Nomad

@export var card_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_dashboard.hand = [GameCards.SLASH]
#	card_dashboard.hand = ["Test card 1"]

func update() -> void:
	pass
