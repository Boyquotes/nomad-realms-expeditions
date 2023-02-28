extends Actor

func _ready():
	rotate_y(randf_range(0, TAU))

func update():
	if !card_player_component.hand.is_empty():
		if card_player_component.hand[0].card == GameCards.REGENESIS:
			# TODO: Play card
			print("Wolf ", self, " played REGENESIS!!")
