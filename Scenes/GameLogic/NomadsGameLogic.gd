extends GameLogic
class_name NomadsGameLogic

@onready var game_logic_timer: = GameLogicTimer.new(self)

@onready var world_map: WorldMap = $"../WorldMap"
@onready var actors: Node3D = $"../Actors"

@export var nomad_scene: PackedScene
@export var boss_scene: PackedScene

func init(context_queues: ContextQueues) -> void:
	super.init(context_queues)
	spawn_nomad()

# Gets called by GameLogicTimer once every tick.
func update() -> void:
	# Equivalent to `super.update()` in Java
	super.update()
	
	# Update all actors
	var actors: = get_tree().get_nodes_in_group("actors")
	for i in range(len(actors)):
		actors[i].update()
	# Push events to GameVisuals

func spawn_nomad():
	var nomad: Nomad = nomad_scene.instantiate() as Nomad
	# Generate a random position to spawn the nomad
	var z = randi() % world_map.tiles.size()
	var x = randi() % world_map.tiles[0].size()
	nomad.position = world_map.tiles[z][x].position
	nomad.position.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE
	actors.add_child(nomad)

func _process(delta: float) -> void:
	game_logic_timer.update(delta)

func _on_boss_spawn_timer_timeout():
	var boss: = boss_scene.instantiate()
	var z = randi() % world_map.tiles.size()
	var x = randi() % world_map.tiles[0].size()
	actors.add_child(boss)
	boss.coordinates = Vector2i(x, z)
	boss.position.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE + 10
	print("NomadsGameLogic.gd: BOSS SPAWNED AT ", boss.coordinates, "!")
