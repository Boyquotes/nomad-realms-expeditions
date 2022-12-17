extends CardExpression
class_name MeleeDamageExpression

var num: int

func _init(num: int):
	self.num = num

func handle(_player: CardPlayer, _target: GameObject):
	# new MeleeDamageEvent(playerID, targetId.as(HealthActorId.class), num)
	pass
