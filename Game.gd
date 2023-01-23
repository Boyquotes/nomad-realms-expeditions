extends Node3D
class_name Game

signal card_played_event(card_player, card, card_target)

@onready var ui_card_dashboard: UICardDashBoard = $UICardDashboard
@onready var camera: Camera3D = $Camera3D
@onready var nomad: Nomad = $Actors/Nomad
@onready var world_map: WorldMap = $WorldMap

var context_queues: = ContextQueues.new()
var card_looking_for_target: WorldCard
var card_target: GameObject

func _ready() -> void:
	print("Starting Nomad Realms Expeditions")
	NomadsGameLogic.init(context_queues)
	$NomadsGameVisuals.init(context_queues)
	world_map.init(NomadsGameLogic.next_state)
	connect("card_played_event", NomadsGameLogic._on_card_played_event)
	set_nomad_position()

func set_nomad_position() -> void:
	# Set nomad position
	var z = randi() % world_map.tiles.size()
	var x = randi() % world_map.tiles[0].size()
	nomad.world_pos = WorldPos.new(0, 0, x, z)
	nomad.position.y += world_map.tiles[z][x].height * Tile.TILE_HEIGHT_SCALE
	nomad.generate_id()

func _unhandled_input(event: InputEvent) -> void:
	if card_looking_for_target == null:
		return
	var card_effect = card_looking_for_target.card.effect

	if card_effect.target_type != 0 && event is InputEventMouseMotion:
		var mouse_pos: Vector2 = event.position
		
		# Find hovered target by casting a ray
		var params: = PhysicsRayQueryParameters3D.new()
		var from: = camera.project_ray_origin(mouse_pos)
		var to: = from + camera.project_ray_normal(mouse_pos) * 400
		params.from = from
		params.to = to
		params.collision_mask = card_effect.target_type
		params.collide_with_areas = true
		params.collide_with_bodies = false
		
		var intersected: = get_world_3d().direct_space_state.intersect_ray(params)
		
		if intersected.has("collider"):
			if card_target != null:
				# Unhighlight previous target
				card_target.highlighted = false
			var potential_target = intersected.collider.get_parent()
			var target_predicate = card_effect.target_predicate
			if target_predicate != null && target_predicate.call(nomad, potential_target):
				card_target = intersected.collider.get_parent()
				card_target.highlighted = true
			else:
				card_target = null
	detect_card_play()

func detect_card_play():
	if !Input.is_action_just_released("interact"):
		return
	var card: = card_looking_for_target.card
	var target_predicate = card.effect.target_predicate
	if target_predicate != null && !target_predicate.call(nomad, card_target):
		return
	emit_signal("card_played_event", nomad, card_looking_for_target, card_target)
	ui_card_dashboard.card_played_cleanup()
	
	card_looking_for_target = null
	if card_target != null:
		card_target.highlighted = false
		card_target = null

func _on_ui_card_dashboard_card_looking_for_target(card):
	card_looking_for_target = card

func _on_ui_card_dashboard_card_not_looking_for_target(card):
	if card_target != null:
		card_target.highlighted = false
		card_target = null
	card_looking_for_target = null
