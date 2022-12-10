signal card_selected
signal card_played
signal card_cancelled

extends GameCardGui
class_name WorldCard

var card: GameCard

func init(card: GameCard) -> void:
	self.card = card
	$NameLabel.text = card.name
	$TextLabel.text = card.text
