extends Actor

func _ready():
	super()
	world_pos = WorldPos.new(0, 0, 8, 8)
	card_player_component.hand.append(CardInstance.new(Cards.zap))
	card_player_component.hand.append(CardInstance.new(Cards.zap))
