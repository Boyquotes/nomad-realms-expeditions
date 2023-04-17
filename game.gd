extends Node3D

signal card_played_event(card_player, card, card_target)

@export var spawn_particles_scene: PackedScene

@onready var ui: = $UI
@onready var nomad: Actor = $Nomad
@onready var camera: Camera3D = $Camera
@onready var world_map: WorldMap = $WorldMap

func _ready() -> void:
	print("game.gd _ready()")
	
	set_nomad_position()
	var particles: = spawn_particles_scene.instantiate()
	add_child(particles)
	particles.position += nomad.position
	particles.emitting = true

func _unhandled_key_input(event) -> void:
	if Input.is_action_just_released("exit"):
		get_tree().quit()

func set_nomad_position() -> void:
	var empty_positions: Array[WorldPos] = []
	for i in range(world_map.actors.size()):
		for j in range(world_map.actors[i].size()):
			if world_map.actors[i][j]:
				continue
			empty_positions.append(WorldPos.new(j, i))
	var world_pos: = empty_positions[empty_positions.size() / 2 - 2]
	nomad.world_pos = world_pos
	world_map.actors[world_pos.tile_pos.y][world_pos.tile_pos.x] = nomad

func _on_spawn_player_timer_timeout() -> void:
	nomad.visible = true

func _on_tick_timer_timeout() -> void:
	var card_played_events: = Global.card_played_events
	Global.card_played_events = []
	for card_played_event in card_played_events:
		var cpe: CardPlayedEvent = card_played_event
		cpe.card_instance.card.card_effect._handle(cpe.player, cpe.target)
	
	for a in get_tree().get_nodes_in_group("actors"):
		var actor: Actor = a
		if actor.ai_component:
			actor.ai_component.update(actor)
