extends Object
class_name GameState

var cards: = {}
var actors: = {}

var chains: Array[Array] = []

# The below are transient (not serialized)
var card_players: = {}
var chunk_to_actors: = {}

func add(actor: Actor):
	actors[actor.id] = actor
