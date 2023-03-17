extends Node3D

@export var camera: Camera3D
@export var bound_actor: Actor

var card_gui_looking_for_target: CardGui
var card_target: Actor

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
		params.collide_with_areas = true
		params.collide_with_bodies = false
		
		var intersected: = get_world_3d().direct_space_state.intersect_ray(params)
		
		if intersected.has("collider"):
			if card_target != null:
				# Unhighlight previous target
				card_target.highlighted = false
			var potential_target = intersected.collider.get_parent()
			var target_predicate = card_effect.target_predicate
			if target_predicate != null && target_predicate.call(bound_actor, potential_target):
				card_target = intersected.collider.get_parent()
				card_target.highlighted = true
			else:
				card_target = null
