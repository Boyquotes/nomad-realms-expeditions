extends Node

# Autoloaded

var card_played_events: Array[CardPlayedEvent] = []

func make_card_played_event(player: Actor, card: CardInstance, target: Actor):
	card_played_events.append(CardPlayedEvent.new(player, card, target))
