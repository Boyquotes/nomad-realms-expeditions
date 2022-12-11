extends Node
# A singleton class containing constants


var REGENESIS: = GameCard.new(
	"Regenesis", 10, "Shuffle your discard into your deck", 0, \
	CardEffect.new(0, null, null, null))
var SLASH: = GameCard.new("SlashAAAA", 1, "Deal 3", 0, \
	CardEffect.new(0b1111, null, null, null))
