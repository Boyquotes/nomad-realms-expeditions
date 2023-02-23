extends CardExpression
class_name RegenesisExpression

func handle(player: Actor, _target: Actor, event_heap: Array[ExpressionEvent]):
	player.card_dashboard.deck.append_array(player.card_dashboard.discard)
	player.card_dashboard.discard.clear()
	
