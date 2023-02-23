extends CardExpression
class_name TeleportExpression

func handle(player: Actor, target: Actor, event_heap: Array[ExpressionEvent]):
	var tile: = target as Tile
	event_heap.append(TeleportEvent.new(player.id, tile.world_pos))
