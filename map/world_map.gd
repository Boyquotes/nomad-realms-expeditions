extends Node3D
class_name WorldMap

@export_range(0, 2) var preset: = 0

@export var tile_scene: PackedScene
@export var tree_scene: PackedScene
@export var wolf_scene: PackedScene
@export var target_dummy_scene: PackedScene
@export var tree_density: = 0.3
@export var wolf_density: = 0.1

var tiles: Array[Array] = []
var actors: Array[Array] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(16):
		tiles.append([])
		actors.append([])
		tiles[i].resize(16)
		actors[i].resize(16)
	Global.world_map = self
	generate_children()

func generate_children():
	generate_terrain()
	generate_actors()

func generate_terrain() -> void:
	for i in range(16):
		for j in range(16):
			var tile = tile_scene.instantiate()
			if not Engine.is_editor_hint():
				tile.world_pos = WorldPos.new(j, i)
			tiles[i][j] = tile
			tile.position.y = -1
			add_child(tile)
			tile.world_pos = WorldPos.new(j, i)

func generate_actors() -> void:
	if preset == 1:
		var wolf: = wolf_scene.instantiate()
		wolf.world_pos = WorldPos.new(10, 7)
		add_child(wolf)
		var tree: = tree_scene.instantiate()
		tree.world_pos = WorldPos.new(11, 9)
		add_child(tree)
		var target_dummy: = target_dummy_scene.instantiate()
		target_dummy.world_pos = WorldPos.new(9, 8)
		add_child(target_dummy)
	else:
		for i in range(16):
			for j in range(16):
				var rand: = randf()
				var actor: Actor
				if rand < tree_density:
					actor = tree_scene.instantiate()
					actor.scale *= randf_range(1, 1.5)
				elif rand < tree_density + wolf_density:
					actor = wolf_scene.instantiate()
				else:
					continue
				
				actor.world_pos = WorldPos.new(j, i)
				actor.rotation.y = randf_range(0, 2 * PI)
				add_child(actor)
				actors[i][j] = actor
