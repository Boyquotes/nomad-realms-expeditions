extends Node3D

@onready var nomad: = $Nomad
@onready var world_map: = $WorldMap

func _ready():
	print("Nomad Realms Expeditions")

func _on_spawn_player_timer_timeout():
	nomad.visible = true
	nomad.position.y = 1
