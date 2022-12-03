extends Node
class_name NREGameContext

onready var world_map: Spatial = $WorldMap
onready var nomad: Spatial = $Actors/Nomad

var context_queues: = ContextQueues.new()

func _ready() -> void:
	$GameLogicTimer.get_child(0).init(context_queues)
	$GameVisuals.init(context_queues)
	spawn_nomad()

func spawn_nomad():
	# Generate a random position to spawn the nomad
	var z = randi() % world_map.tiles.size()
	var x = randi() % world_map.tiles[0].size()
	
	nomad.translation = world_map.tiles[z][x].translation
	nomad.translation.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE
