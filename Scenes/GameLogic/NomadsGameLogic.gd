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
	nomad.world_pos = WorldPos.new(0, 0, x, z)
	nomad.position.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE
	actors.add_child(nomad)

func _process(delta: float) -> void:
	game_logic_timer.update(delta)

func _on_boss_spawn_timer_timeout():
	var boss: = boss_scene.instantiate()
	var z = randi() % world_map.tiles.size()
	var x = randi() % world_map.tiles[0].size()
	actors.add_child(boss)
	boss.world_pos = WorldPos.new(0, 0, x, z)
	boss.position.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE + 10
	print("NomadsGameLogic.gd: BOSS SPAWNED AT ", boss.world_pos, "!")


func _on_nomads_game_input_card_played_event(card_player: CardPlayer, card: WorldCard, card_target):
	var card_model = card.card
	print("You just played a card: ", card_model.name, " on ", card_target)
	card_model.effect.expression.handle(card_player, card_target)
	# TODO: push an event instead of handling logic inside input
	card_player.card_dashboard.discard.append(card)
	var hand: = card_player.card_dashboard.hand
	hand.remove_at(hand.find(card))
	card.free()
	card = null
