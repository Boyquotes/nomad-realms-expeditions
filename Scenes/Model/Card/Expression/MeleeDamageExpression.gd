extends CardExpression
class_name MeleeDamageExpression

var num: int

func _init(num: int):
	self.num = num

func handle(_player: CardPlayer, target: GameObject):
	target.health -= num
