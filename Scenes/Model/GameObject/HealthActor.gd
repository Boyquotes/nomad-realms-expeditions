extends Actor
class_name HealthActor

var health: int : set = set_health

func set_health(new_value: int):
	health = new_value
	if health <= 0:
		die()

func copy_to(object) -> void:
	object.health = health
	super.copy_to(object)
