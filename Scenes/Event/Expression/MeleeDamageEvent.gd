extends ExpressionEvent
class_name MeleeDamageEvent

var damage: int
var player_id: int
var target_id: int

func _init(damage: int, player_id: int, target_id: int):
	self.damage = damage
	self.player_id = player_id
	self.target_id = target_id

func process(tick: int, next_state: GameState) -> void:
	(next_state.get_actor(target_id) as HealthActor).health -= damage

func get_priority() -> int:
	return 3
