extends Node3D

@export var camera: Camera3D
@export var bound_actor: Actor

@onready var card_dashboard_gui: CardDashboardGui = $SubViewportContainer/SubViewport/CardDashboardGui

var card_gui_looking_for_target: CardGui
var card_target: Actor

func _ready():
	card_dashboard_gui.bound_actor = bound_actor

func _unhandled_input(event):
	if card_gui_looking_for_target == null:
		return
	var card_instance: = card_gui_looking_for_target.card_instance
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
		
		var collision: = get_world_3d().direct_space_state.intersect_ray(params)
		
		if "collider" in collision:
			if card_target != null:
				# Unhighlight previous target
				card_target.set_highlighted(false)
			card_target = collision.collider.get_parent().get_parent()
			# TODO: Target Predicate (e.g. range)
#			var target_predicate = card.target_predicate
#			if target_predicate != null && target_predicate.call(bound_actor, potential_target):
#				card_target = collision.collider.get_parent()
#				card_target.set_highlighted(true)
			if true:
				card_target.set_highlighted(true)
			else:
				card_target = null
			get_viewport().set_input_as_handled()
		else:
			if card_target:
				card_target.set_highlighted(false)
	elif Input.is_action_just_released("interact"):
		if card.target_type > 0 && not card_target:
			return
		var card_player: = bound_actor.card_player_component
		card_player.move_card_instance(card_instance, "hand", "discard")
		# We don't handle the effect immediately. Instead, we queue it up
		# and it is handled the next tick
		Global.make_card_played_event(bound_actor, card_instance, card_target)
		if card_target:
			card_target.set_highlighted(false)
			card_target = null
		card_gui_looking_for_target = null

func _on_card_dashboard_gui_set_card_gui_looking_for_target(card_gui):
	card_gui_looking_for_target = card_gui
	if !card_gui and card_target:
		card_target.set_highlighted(false)
