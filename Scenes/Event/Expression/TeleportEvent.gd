extends ExpressionEvent
class_name TeleportEvent

var player_id: int
var target_pos: WorldPos

func _init(player_id: int, target_pos: WorldPos):
	self.player_id = player_id
	self.target_pos = target_pos

func process(tick: int, next_state: GameState) -> void:
	(next_state.get_actor(player_id) as Actor).world_pos = target_pos

func get_priority() -> int:
	return 9
