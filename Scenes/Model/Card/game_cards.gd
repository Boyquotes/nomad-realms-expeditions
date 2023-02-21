extends Node
# A singleton class containing constants

enum { BASIC, COMMON, RARE, CROMULENT }

# CardEffect constructor:
# target_type: int, target_predicate: Callable, expression: CardExpression
var TELEPORT: = GameCard.new("Teleport", 1, \
	"Teleport to target tile within range 4", BASIC, \
	CardEffect.new(0b0001, range_predicate(4), TeleportExpression.new()))
var REGENESIS: = GameCard.new("Regenesis", 10, \
	"Shuffle your discard into your deck", BASIC, \
	CardEffect.new(0b0000, none(), RegenesisExpression.new()))
var SLASH: = GameCard.new("Slash", 1, \
	"Deal 4 to a target within range 2", BASIC, \
	CardEffect.new(0b1110, range_predicate(2), MeleeDamageExpression.new(4)))

# Predicates

func none() -> Callable:
	return func(cp, ct):
		return true

func range_predicate(range: int) -> Callable:
	return func(cp, ct):
		return ct != null && ct.world_pos.distance_to(cp.world_pos) <= range
