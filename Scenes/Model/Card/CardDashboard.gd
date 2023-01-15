extends Object
class_name CardDashboard

var deck: Array[GameCard] = []
var hand: Array[GameCard] = []
var discard: Array[GameCard] = []

func copy() -> CardDashboard:
	var copy = CardDashboard.new()
	copy.deck.append_array(deck)
	copy.hand.append_array(hand)
	copy.discard.append_array(discard)
	return copy
