extends Node3D
class_name WorldMap

@export var tile_scene: PackedScene
@export var tree_scene: PackedScene
@export var wolf_scene: PackedScene

var tiles: Array[Array] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	generate_tiles()
	generate_actors()
	

func generate_tiles() -> void:
	var noise: = FastNoiseLite.new()
	noise.offset = Vector3(0.5, 0.5, 0.5)
	noise.seed = 14
	noise.frequency = 0.1
	for z in range(16):
		tiles.append([])
		for x in range(16):
			var tile: Tile = tile_scene.instantiate()
			var h: int = int((noise.get_noise_2d(x, z + (z % 2) * 0.5) + 1) * 10)
			tile.initialize(x, z, h, Color(0, 1, 0))
			tile.set_name("Tile" + str(x) + "_" + str(z))
			add_child(tile)
			tiles[-1].append(tile)

func generate_actors() -> void:
	for z in range(16):
		for x in range(16):
			var tile: Tile = tiles[z][x]
			var rand: = randi() % 15
			if rand == 0:
				var tree: TreeActor = tree_scene.instantiate()
				tree.world_pos = WorldPos.new(0, 0, x, z)
				tree.position.y = tile.scale.y
				add_child(tree)
			elif rand == 1:
				var wolf: WolfActor = wolf_scene.instantiate()
				wolf.card_dashboard.hand.append(GameCards.SLASH)
				wolf.card_dashboard.hand.append(GameCards.SLASH)
				wolf.card_dashboard.hand.append(GameCards.REGENESIS)
				wolf.world_pos = WorldPos.new(0, 0, x, z)
				wolf.position.y = tile.scale.y
				add_child(wolf)

