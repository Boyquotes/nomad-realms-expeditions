extends Object
class_name GameState

var cards: = {}
var actors: = {}

var chains: Array[Array] = []

# The below are transient (not serialized)
var card_players: = {}
var chunk_to_actors: = {}

var expression_event_heap: Array[ExpressionEvent] = []

func add(actor: Actor):
	actors[actor.id] = actor

func get_actor(id: int) -> Actor:
	return actors[id]

func copy() -> GameState:
	var copy: = GameState.new()
	for card in cards:
		copy.cards[card] = cards[card]
	for actor in actors:
		copy.actors[actor] = actors[actor]
	for chain in chains:
		copy.chains.append(chain)
	copy.card_players = card_players
	copy.chunk_to_actors = chunk_to_actors
	for event in expression_event_heap:
		copy.expression_event_heap.append(event)
	return copy
