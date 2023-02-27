extends GameLogic

@onready var game_logic_timer: = GameLogicTimer.new(self)

@onready var world_map: WorldMap = $"../WorldMap"
@onready var actors: Node3D = $"../Actors"

@export var nomad_scene: PackedScene
@export var boss_scene: PackedScene

var game_states: Array[GameState] = []
var next_state: GameState = GameState.new()

func init(context_queues: ContextQueues) -> void:
	super.init(context_queues)
	advance_state()

# Gets called by GameLogicTimer once every tick.
func update() -> void:
	super.update()
	next_state.expression_event_heap.sort_custom( \
		func(a, b): return a.priority() < b.priority \
	)
	while next_state.expression_event_heap.size() > 0:
		var event: ExpressionEvent = next_state.expression_event_heap.pop_front()
		event.process(game_tick, next_state)

#	# Update all actors
#	var actors: = get_tree().get_nodes_in_group("actors")
#	for actor in actors:
#		actor.update()
	
	# Everyone draws a card if game_tick is divisible by 20
#	if game_tick != 0 && game_tick % 20 == 0:
#		var actors: = get_tree().get_nodes_in_group("actors")
#		for cp in actors:
#			var actor: CardPlayer = cp as CardPlayer
#			var dashboard: = actor.card_dashboard
#			if dashboard.deck.size() > 0:
#				if dashboard.hand.size() == 8:
#					dashboard.discard.append(dashboard.hand.pop_front())
#				dashboard.hand.append(dashboard.deck.pop_front())
	
	# Push events to GameVisuals
	
#	advance_state()

func advance_state() -> void:
	game_states.append(next_state.copy())
	while game_states.size() > 30:
		game_states.pop_front()

func current_state() -> GameState:
	return game_states[-1]

func _process(delta: float) -> void:
	game_logic_timer.update(delta)

func _on_boss_spawn_timer_timeout() -> void:
	var boss: = boss_scene.instantiate()
	var z = randi() % world_map.tiles.size()
	var x = randi() % world_map.tiles[0].size()
	actors.add_child(boss)
	boss.world_pos = WorldPos.new(0, 0, x, z)
	boss.position.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE + 10
	print("NomadsGameLogic.gd: BOSS SPAWNED AT ", boss.world_pos, "!")

# Connected to game.tscn's card_played_event signal
func _on_card_played_event(actor: Actor, card: WorldCard, card_target):
	var card_player_component: = actor.card_player_component
	var card_model = card.card
	print("You just played a card: ", card_model.name, " on ", card_target)
	card_model.effect.expression.handle(actor, card_target, next_state.expression_event_heap)
	# Maybe we can await a timer timeout and then execute the expression...
	# TODO: push an event instead of handling logic inside input
	card_player_component.discard.append(card)
	var hand: = card_player_component.hand
	hand.remove_at(hand.find(card))
	card.free()
	card = null
