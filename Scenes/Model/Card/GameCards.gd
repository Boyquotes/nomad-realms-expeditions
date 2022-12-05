extends Object
# A singleton class containing constants


var REGENESIS = GameCard.new(
	"Regenesis", 10, "Shuffle your discard into your deck", 0, \
	CardEffect.new(0, null, null, null))
var SLASH: GameCard = GameCard.new("Slash", 1, "Deal 3", 0, \
	CardEffect.new(0, null, null, null))
