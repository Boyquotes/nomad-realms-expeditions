extends Node
class_name GameLogic

var game_tick: = 0

var context_queues: ContextQueues

func init(context_queues: ContextQueues) -> void:
	self.context_queues = context_queues

func update():
	game_tick += 1
