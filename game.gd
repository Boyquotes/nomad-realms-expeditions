extends Node3D

signal card_played_event(card_player, card, card_target)

@onready var card_dashboard_gui: = $CardDashboardGui
@onready var nomad: Actor = $Nomad
@onready var camera: Camera3D = $Camera
@onready var world_map: = $WorldMap
var card_looking_for_target: CardGui
var card_target: Actor

func _ready():
	print("Nomad Realms Expeditions")
	$SpawnParticles.position += nomad.position
	$SpawnParticles.emitting = true


func _unhandled_input(event: InputEvent) -> void:
	if card_looking_for_target == null:
		return
	var card_instance: = card_looking_for_target.card_instance
	var card: = card_instance.card
	var card_effect: = card.card_effect

	if card.target_type != 0 && event is InputEventMouseMotion:
		var mouse_pos: Vector2 = event.position
		
		# Find hovered target by casting a ray
		var params: = PhysicsRayQueryParameters3D.new()
		var from: = camera.project_ray_origin(mouse_pos)
		var to: = from + camera.project_ray_normal(mouse_pos) * 400
		params.from = from
		params.to = to
		params.collision_mask = card.target_type # Important!
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
	var card: = card_looking_for_target.card_instance
	var target_predicate = card.effect.target_predicate
	if target_predicate != null && !target_predicate.call(nomad, card_target):
		return
	emit_signal("card_played_event", nomad, card_looking_for_target, card_target)
#	card_dashboard_gui.card_played_cleanup()
	
	card_looking_for_target = null
	if card_target != null:
		card_target.highlighted = false
		card_target = null
	
func _on_spawn_player_timer_timeout():
	nomad.visible = true
	nomad.position.y = 1
