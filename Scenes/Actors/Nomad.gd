extends CardPlayer
class_name Nomad

export (PackedScene) var card_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_dashboard.hand = [GameCard.new("Slash", 1, "Deal 3", 0, \
	CardEffect.new(0, null, null, null))]
#	card_dashboard.hand = ["Test card 1"]

func update() -> void:
	pass
