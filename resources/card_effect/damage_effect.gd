extends CardEffect
class_name DamageEffect

@export_range(0, 10000) var damage: int = 1

func _handle(actor: Actor, target: Actor) -> void:
	target.health_component.health -= damage
