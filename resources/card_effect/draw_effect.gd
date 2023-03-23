extends CardEffect
class_name DrawEffect

@export_range(0, 10000) var num_cards: int = 1

func _handle(actor: Actor, target: Actor) -> void:
	# If no target, then the player of the card draws
	if !target:
		target = actor
	for i in range(num_cards):
		var cpc: = target.card_player_component
		if cpc.deck.is_empty():
			break
		cpc.move_card_instance(cpc.deck[0], "deck", "hand")
