extends Node3D
class_name HealthComponent

signal health_changed(old, new)
signal health_depleted

@export var initial_health: int = 20

var health: int = initial_health : set = _set_health

func _set_health(h: int) -> void:
	if health != h:
		emit_signal("health_changed", health, h)
	if h <= 0:
		emit_signal("health_depleted")
	health = h
