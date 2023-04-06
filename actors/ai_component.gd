extends Node
class_name AiComponent

const wait_times: Array[int] = [40, 30, 25, 20, 15]

@export_range(0, 4) var intelligence: int = 0
@export_range(1, 8) var sight: int = 3

var wait_time_remaining: int = wait_times[intelligence]

func update(actor: Actor):
	if wait_time_remaining == 0:
		_play_cards(actor)
		wait_time_remaining = wait_times[intelligence]
	else:
		wait_time_remaining -= 1

func _calculate_state(actor: Actor):
	var pos: = actor.world_pos
	var world_map: = Global.world_map
	var top_left_x: = pos.tile_pos.x - sight
	var top_left_y: = pos.tile_pos.y - sight
	
	var surroundings: Array[Array] = []
	for i in range(2 * sight + 1):
		surroundings.append([])
		surroundings[i].resize(2 * sight + 1)
	
	for i in range(2 * sight + 1):
		for j in range(2 * sight + 1):
			var x: = top_left_x + j
			var y: = top_left_y + i
			surroundings[i][j] = world_map.actors[y][x]
	
	return surroundings

func _play_cards(actor: Actor):
	var card_player_component: = actor.card_player_component
	if card_player_component.hand.is_empty():
		return
	else:
#		print("There are some cards in hand!")
		var hand: = card_player_component.hand
