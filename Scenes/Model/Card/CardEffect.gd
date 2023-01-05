extends Object
class_name CardEffect

enum TargetType {
	TILES = 1, FRIENDLY_ACTORS = 2, ENEMY_ACTORS = 4, NEUTRAL_ACTORS = 8
}

# A mask
var target_type: int
var target_predicate # Callable, aka Function in Java
var expression: CardExpression

func _init(target_type: int, target_predicate, expression: CardExpression):
	self.target_type = target_type;
	self.target_predicate = target_predicate;
	self.expression = expression;
