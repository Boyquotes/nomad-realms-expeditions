extends Object
class_name GameCard

var name: String
var cost: int
var text: String
#var type: CardType
var rarity: int
var effect: CardEffect

func _init(name: String, cost: int, text: String, rarity: int, effect: CardEffect) -> void:
	self.name = name
	self.cost = cost
	self.text = text
	self.rarity = rarity
	self.effect = effect
