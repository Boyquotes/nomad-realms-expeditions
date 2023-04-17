extends Node
class_name HealthComponent

signal health_changed(old, new)
signal health_depleted

@export var starting_health: int = 10
@export var delete_on_death: bool = true

var health: int : set = _set_health

func _ready():
	health = starting_health

func _set_health(h: int) -> void:
	if h != health:
		emit_signal('health_changed', health, h)
	if h <= 0:
		emit_signal('health_depleted')
		if delete_on_death:
			get_parent().queue_free()
	health = h

func serialize() -> int:
	return starting_health << 16 || health
