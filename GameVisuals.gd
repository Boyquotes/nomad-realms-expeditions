extends Spatial

var context_queues: ContextQueues

func init(context_queues: ContextQueues) -> void:
	self.context_queues = context_queues

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if len(context_queues.logic_to_visuals) > 0:
		# Handle event from queue
		pass
