extends Node3D

signal card_played_event(card_player, card, card_target)

@onready var ui: = $UI
@onready var nomad: Actor = $Nomad
@onready var camera: Camera3D = $Camera
@onready var world_map: = $WorldMap

func _ready():
	print("Nomad Realms Expeditions")
	$SpawnParticles.position += nomad.position
	$SpawnParticles.emitting = true

func _on_spawn_player_timer_timeout():
	nomad.visible = true
	nomad.position.y = 1




