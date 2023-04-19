extends Actor

func _ready():
	super()
	world_pos = WorldPos.new(8, 8)
	card_player_component.hand.append(CardInstance.new(Cards.preparation))
	card_player_component.hand.append(CardInstance.new(Cards.zap))
	card_player_component.deck.append(CardInstance.new(Cards.preparation))
	card_player_component.deck.append(CardInstance.new(Cards.zap))
