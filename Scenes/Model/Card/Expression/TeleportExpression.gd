extends CardExpression
class_name TeleportExpression

func handle(player: CardPlayer, target: GameObject):
	print("REEEEE")
	var tile: = target as Tile
	player.coordinates = tile.coordinates
	player.position.y = tile.scale.y
