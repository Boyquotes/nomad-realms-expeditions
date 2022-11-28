extends GameLogic
class_name NREGameLogic

func _ready() -> void:
	pass

# Gets called by GameLogicTimer once every tick.
func update() -> void:
	# Equivalent to `super.update()` in Java
	.update()
	
	# Update all actors
#	get_tree().get_nodes_in_group("actor")
	# Push events to GameVisuals
