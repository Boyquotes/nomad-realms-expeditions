extends GameEvent
class_name ExpressionEvent

func process(tick: int, next_state: GameState) -> void:
	pass

func get_priority() -> int:
	return 0

func get_process_time() -> int:
	return 1
