extends Spatial

export (PackedScene) var card_scene

var cards: Array = ["Test card"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(cards.size()):
		var new_card = card_scene.instance()
		# Set new card type...
		$HandZone/Cards.add_child(new_card)
