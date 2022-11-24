extends Spatial

func _ready() -> void:
	# Wait for the rest of the scene to load
	yield(get_tree().root, "ready")
	
	var world_map: Spatial = $WorldMap
	var nomad: Spatial = $Actors/Nomad
	
	# Generate a random position to spawn the nomad
	var z = randi() % world_map.tiles.size()
	var x = randi() % world_map.tiles[0].size()
	
	nomad.translation = world_map.tiles[z][x].translation
	nomad.translation.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE
	
