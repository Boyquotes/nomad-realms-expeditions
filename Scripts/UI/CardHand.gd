extends Control
class_name CardHand

var cards: Array = []

func reset_target_positions() -> void:
	var num_cards: = cards.size()
	var screen_x = get_viewport().size.x
	var screen_y = get_viewport().size.y
	print(get_viewport().size)
	for i in range(cards.size()):
		var card = cards[i]
		card.target_position.x = screen_x * (i + 0.5) / num_cards
		card.target_position.x += (0.5 * screen_x - card.target_position.x) * 0.6
		card.target_position.y = screen_y * 0.95
		print(card.target_position)
	
func add_card(card: Node) -> void:
	cards.append(card)
	add_child(card)
	
