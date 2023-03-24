extends Node3D

@export var tile_scene: PackedScene
@export var tree_scene: PackedScene
@export var wolf_scene: PackedScene
@export var tree_density: = 0.3
@export var wolf_density: = 0.1

var tiles: Array[Array] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_terrain()
	generate_trees()
	pass

func generate_terrain() -> void:
	for i in range(16):
		tiles.append([])
		tiles[i].resize(16)
		for j in range(16):
			var tile = tile_scene.instantiate()
			tile.name = "Tile%d_%d" % [j, i]
			tile.world_pos = WorldPos.new(0, 0, j, i)
			tiles[i][j] = tile
			add_child(tile)

func generate_trees() -> void:
	for i in range(16):
		for j in range(16):
			var rand: = randf()
			if rand < tree_density:
				var tree = tree_scene.instantiate()
				tree.name = "Tree%d_%d" % [j, i]
				tree.world_pos = WorldPos.new(0, 0, j, i)
				tree.position.y = 1
				tree.rotation.y = randf_range(0, 2 * PI)
				tree.scale *= randf_range(1, 1.5)
				add_child(tree)
			elif rand < tree_density + wolf_density:
				var wolf = wolf_scene.instantiate()
				wolf.world_pos = WorldPos.new(0, 0, j, i)
				wolf.position.y = 1
				wolf.rotation.y = randf_range(0, 2 * PI)
				add_child(wolf)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
