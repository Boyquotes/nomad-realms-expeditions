extends Node3D
class_name GameInput

var card_looking_for_target: WorldCard
var ui_card_dashboard: UICardDashBoard

var camera: Camera3D
var card_target: GameObject
var nomad: Nomad

func init(context_queues: ContextQueues) -> void:
	ui_card_dashboard = $"../UICardDashboard"
	camera = $"../CameraPivot/Camera3D"
	nomad = $"../Actors/Nomad"

func _unhandled_input(event: InputEvent) -> void:
	if card_looking_for_target == null:
		return
	var card_effect = card_looking_for_target.card.effect
	if card_effect.target_type == 0:
		return

	if event is InputEventMouseMotion:
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
			card_target = intersected.collider.get_parent()
			if card_target is Tile:
				card_target.highlighted = true
			else:
				card_target.highlighted = true
	detect_card_play()

func detect_card_play():
	if Input.is_action_just_released("interact"):
		var card: = card_looking_for_target.card
		print("You just played a card: ", card_looking_for_target.card.name, \
			" on ", card_target, " Expression: ", card.effect.expression.name())
		card.effect.expression.handle(nomad, card_target)
		card_target.highlighted = false
		card_target = null
		card_looking_for_target.free()
		card_looking_for_target = null
		ui_card_dashboard.card_played_cleanup()

func _on_UICardDashboard_card_looking_for_target(card: WorldCard) -> void:
	card_looking_for_target = card

func _on_UICardDashboard_card_not_looking_for_target(card: WorldCard) -> void:
	if card_target != null:
		card_target.highlighted = false
		card_target = null
	card_looking_for_target = null
