extends Spatial
class_name Main

onready var world_map: Spatial = $WorldMap
onready var nomad: Spatial = $Actors/Nomad

func _ready() -> void:
	
	# Generate a random position to spawn the nomad
	var z = randi() % world_map.tiles.size()
	var x = randi() % world_map.tiles[0].size()
	
	nomad.translation = world_map.tiles[z][x].translation
	nomad.translation.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE
