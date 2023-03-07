extends Node
class_name HealthComponent

signal health_changed(old, new)
signal health_depleted

@export var starting_health: int = 10
var health: int = starting_health : set = _set_health

func _set_health(h: int) -> void:
	if h != health:
		emit_signal('health_changed', health, h)
	if h <= 0:
		emit_signal('health_depleted')
	health = h