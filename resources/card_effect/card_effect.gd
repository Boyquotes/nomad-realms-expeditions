extends Resource
class_name CardEffect

func _handle(actor: Actor, target: Actor) -> void:
	pass

func suggest_targets(surroundings: Array[Array], player: Actor) -> Array[Actor]:
	return []

func calculate_playability(surroundings: Array[Array], player: Actor) -> float:
	assert(false, "ERROR: calculate_playability() function not overriden.")
	return 0
