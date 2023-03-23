extends Resource
class_name CardPlayedEvent

var player: Actor
var card_instance: CardInstance
var target: Actor

func _init(p: Actor, c: CardInstance, t: Actor):
	player = p
	card_instance = c
	target = t
