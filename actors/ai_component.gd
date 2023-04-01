extends Node
class_name AiComponent

const wait_times: Array[int] = [40, 30, 25, 20, 15]

@export_range(0, 4) var intelligence: int = 0

var wait_time_remaining: int = wait_times[intelligence]

func update(actor: Actor):
	if wait_time_remaining == 0:
		_play_cards(actor)
		wait_time_remaining = wait_times[intelligence]
	else:
		wait_time_remaining -= 1

func _play_cards(actor: Actor):
	var card_player_component: = actor.card_player_component
	if card_player_component.hand.is_empty():
		return
	else:
#		print("There are some cards in hand!")
		var hand: = card_player_component.hand
