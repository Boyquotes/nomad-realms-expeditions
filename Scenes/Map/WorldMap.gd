extends Spatial
class_name WorldMap

export (PackedScene) var tile_scene
export (PackedScene) var tree_scene

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
			if randi() % 2 == 0:
				var tree: TreeActor = tree_scene.instance()
				var position = Vector2(x, z)
				translation.x = 1.5 * x
				height = randi() % TILE_MAX_HEIGHT + 1
			#	height = 1
				scale.y = height * TILE_HEIGHT_SCALE
				translation.z = sqrt(3) * z
				add_child(tile)
