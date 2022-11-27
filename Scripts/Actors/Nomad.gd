extends Spatial

export (PackedScene) var card_scene

var cards: Array = ["Test card", "Test card 2", "Test card 3", "Test card 4"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(cards.size()):
		var new_card: Card = card_scene.instance()
		new_card.reset_position(i, cards.size());
		# Set new card type...
#		$HandZone/Cards.add_child(new_card)
