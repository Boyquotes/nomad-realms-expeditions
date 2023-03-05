extends CardEffect
class_name AndEffect

@export var card_effect1: CardEffect
@export var card_effect2: CardEffect

func _handle(actor: Actor, target: Actor) -> void:
	card_effect1._handle(actor, target)
	card_effect2._handle(actor, target)
