extends GameLogic
class_name NREGameLogic


# Gets called by GameLogicTimer once every tick.
func update() -> void:
	# Equivalent to `super.update()` in Java
	.update()
	
	# Update all actors
	var actors: = get_tree().get_nodes_in_group("actors")
	for i in range(len(actors)):
		actors[i].update()
	# Push events to GameVisuals
