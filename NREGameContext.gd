extends Node
class_name NREGameContext

var context_queues: = ContextQueues.new()

func _ready() -> void:
	print("Starting Nomad Realms Expeditions")
	$NomadsGameLogic.init(context_queues)
	$NomadsGameVisuals.init(context_queues)
	$NomadsGameInput.init(context_queues)
