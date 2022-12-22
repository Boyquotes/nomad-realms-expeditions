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
	for z in range(16):
		tiles.append([])
		for x in range(16):
			var tile: Tile = tile_scene.instantiate()
			tile.initialize(x, z, Color(0, 1, 0))
			
			tile.set_name("Tile" + str(z) + "_" + str(x))
			add_child(tile)
			tiles[-1].append(tile)
			generate_tree(x, z, tile)

func generate_actors() -> void:
	for z in range(16):
		for x in range(16):
			var tile: Tile = tiles[z][x]
			var rand: = randi() % 20
			if rand == 0:
				var tree: TreeActor = tree_scene.instantiate()
				var position = Vector2(x, z)
				tree.position.x = 1.5 * x
				tree.position.y = tile.scale.y
				tree.position.z = sqrt(3) * z
				if x % 2 == 1:
					tree.position.z += sqrt(3) * 0.5
				add_child(tree)
			elif rand == 1:
				var wolf: WolfActor = wolf_scene.instantiate()
				var position = Vector2(x, z)
				wolf.position.x = 1.5 * x
				wolf.position.y = tile.scale.y
				wolf.position.z = sqrt(3) * z
				if x % 2 == 1:
					wolf.position.z += sqrt(3) * 0.5
				add_child(wolf)

func generate_tree(x, z, tile) -> void:
	if randi() % 10 == 0:
		var tree: TreeActor = tree_scene.instantiate()
		var position = Vector2(x, z)
		tree.position.x = 1.5 * x
		tree.position.y = tile.scale.y
		tree.position.z = sqrt(3) * z
		if x % 2 == 1:
			tree.position.z += sqrt(3) * 0.5
		add_child(tree)
