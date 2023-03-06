extends TargetPredicate
class_name RangePredicate

@export_range(0, 50) var range: int = 1

func _test(player: Actor, target: Actor) -> bool:
	return target.world_pos.distance_to(player.world_pos) <= range
