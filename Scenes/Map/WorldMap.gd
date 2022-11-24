extends Spatial
class_name WorldMap

export (PackedScene) var tile_scene


var tiles: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	generate_tiles()

func generate_tiles() -> void:
	for z in range(16):
		tiles.append([])
		for x in range(16):
			var tile: Tile = tile_scene.instance()
			tile.initialize(x, z, Color(0, 1, 0))
			
			tile.set_name("Tile" + str(z) + "_" + str(x))
			add_child(tile)
			tiles[-1].append(tile)
