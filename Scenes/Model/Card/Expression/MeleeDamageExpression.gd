extends CardExpression
class_name MeleeDamageExpression

var num: int

func _init(num: int) -> void:
	self.num = num

func handle(playerId: int, targetId: int, state: GameState):
	# new MeleeDamageEvent(playerID, targetId.as(HealthActorId.class), num)
	pass
