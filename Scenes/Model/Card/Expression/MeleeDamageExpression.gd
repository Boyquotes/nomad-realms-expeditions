extends CardExpression
class_name MeleeDamageExpression

var num: int

func _init(num: int):
	self.num = num

func handle(player: CardPlayer, target: GameObject, event_heap: Array[ExpressionEvent]):
	event_heap.append(MeleeDamageEvent.new(num, player.id, target.id))
