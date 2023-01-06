extends CardExpression
class_name TeleportExpression

func handle(player: CardPlayer, target: GameObject):
	var tile: = target as Tile
	player.world_pos = tile.world_pos
	player.position.y = tile.scale.y
