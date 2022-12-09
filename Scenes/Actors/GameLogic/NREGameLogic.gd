extends GameLogic
class_name NREGameLogic

onready var game_logic_timer: = GameLogicTimer.new(self)

onready var world_map: Spatial = $"../WorldMap"
onready var nomad: Spatial = $"../Actors/Nomad"

func init(context_queues: ContextQueues) -> void:
	.init(context_queues)
	spawn_nomad()

# Gets called by GameLogicTimer once every tick.
func update() -> void:
	# Equivalent to `super.update()` in Java
	.update()
	
	# Update all actors
	var actors: = get_tree().get_nodes_in_group("actors")
	for i in range(len(actors)):
		actors[i].update()
	# Push events to GameVisuals

func spawn_nomad():
	# Generate a random position to spawn the nomad
	var z = randi() % world_map.tiles.size()
	var x = randi() % world_map.tiles[0].size()
	
	nomad.translation = world_map.tiles[z][x].translation
	nomad.translation.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE

func _process(delta: float) -> void:
	game_logic_timer.update(delta)

