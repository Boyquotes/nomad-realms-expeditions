extends Node3D
class_name Game

signal card_played_event(card_player, card, card_target)

var context_queues: = ContextQueues.new()
var card_looking_for_target: WorldCard
var ui_card_dashboard: UICardDashBoard

var camera: Camera3D
var card_target: GameObject
@export var nomad: Nomad

@onready var world_map: WorldMap = $WorldMap

func _ready() -> void:
	print("Starting Nomad Realms Expeditions")
	NomadsGameLogic.init(context_queues)
	$NomadsGameVisuals.init(context_queues)
	world_map.init(NomadsGameLogic.next_state)
	ui_card_dashboard = $"../UICardDashboard"
	camera = $"../CameraPivot/Camera3D"
	nomad = $"../Actors/Nomad"

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
	card_looking_for_target = null
	ui_card_dashboard.card_played_cleanup()
	if card_target != null:
		card_target.highlighted = false
		card_target = null

func _on_UICardDashboard_card_looking_for_target(card: WorldCard) -> void:
	card_looking_for_target = card

func _on_UICardDashboard_card_not_looking_for_target(card: WorldCard) -> void:
	if card_target != null:
		card_target.highlighted = false
		card_target = null
	card_looking_for_target = null
