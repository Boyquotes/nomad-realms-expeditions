extends Actor

func _ready():
	world_pos = WorldPos.new(0, 0, 8, 8)
	var zap: = CardInstance.new(Cards.zap)
	card_player_component.hand.append(zap)
