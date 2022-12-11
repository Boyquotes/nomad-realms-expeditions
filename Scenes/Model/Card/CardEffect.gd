extends Object
class_name CardEffect

enum TargetType {
	TILES = 1, FRIENDLY_ACTORS = 4, ENEMY_ACTORS = 8, NEUTRAL_ACTORS = 16
}

# A mask
var target_type: int
var play_predicate
var target_predicate
var expression: CardExpression

func _init(target_type: int, play_predicate, target_predicate, expression: CardExpression):
	self.target_type = target_type;
	self.play_predicate = play_predicate;
	self.target_predicate = target_predicate;
	self.expression = expression;
