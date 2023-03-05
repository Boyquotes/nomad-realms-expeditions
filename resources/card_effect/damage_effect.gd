extends CardEffect
class_name DamageEffect

@export var damage: int

func _handle(actor: Actor, target: Actor) -> void:
	target.health_component.health -= damage
