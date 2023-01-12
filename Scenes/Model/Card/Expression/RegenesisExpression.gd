extends CardExpression
class_name RegenesisExpression

func handle(player: CardPlayer, _target: GameObject, event_heap: Array[ExpressionEvent]):
	player.card_dashboard.deck.append_array(player.card_dashboard.discard)
	player.card_dashboard.discard.clear()
	
