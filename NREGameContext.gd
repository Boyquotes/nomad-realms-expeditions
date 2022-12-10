extends Node
class_name NREGameContext


var context_queues: = ContextQueues.new()

func _ready() -> void:
	$NREGameLogic.init(context_queues)
	$GameVisuals.init(context_queues)
	$GameInput.init(context_queues)
