extends Node3D

signal card_played_event(card_player, card, card_target)

@export var spawn_particles_scene: PackedScene

@onready var ui: = $UI
@onready var nomad: Actor = $Nomad
@onready var camera: Camera3D = $Camera
@onready var world_map: = $WorldMap

func _ready():
	print("Nomad Realms Expeditions")
	var particles: = spawn_particles_scene.instantiate()
	add_child(particles)
	particles.position += nomad.position
	particles.emitting = true

func _unhandled_key_input(event):
	if Input.is_action_just_released("exit"):
		get_tree().quit()

func _on_spawn_player_timer_timeout():
	nomad.visible = true
	nomad.position.y = 1

func _on_tick_timer_timeout():
	var card_played_events: = Global.card_played_events
	Global.card_played_events = []
	for card_played_event in card_played_events:
		var cpe: CardPlayedEvent = card_played_event
		cpe.card_instance.card.card_effect._handle(cpe.player, cpe.target)
	
	for a in get_tree().get_nodes_in_group("actors"):
		var actor: Actor = a
		if actor.ai_component:
			actor.ai_component.update(actor)
