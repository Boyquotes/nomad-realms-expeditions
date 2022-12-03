signal card_selected
signal card_played
signal card_cancelled

extends GameCard
class_name WorldCard

var card_name: String

func init(card_name: String) -> void:
	self.card_name = card_name

