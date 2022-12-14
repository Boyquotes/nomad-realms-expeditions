extends Spatial
class_name GameInput

var card_looking_for_target: WorldCard
var ui_card_dashboard: UICardDashBoard

var camera: Camera
var card_target

func init(context_queues: ContextQueues) -> void:
	ui_card_dashboard = $"../UICardDashboard"
	camera = $"../CameraPivot/Camera"

func _unhandled_input(event: InputEvent) -> void:
	if card_looking_for_target == null:
		return
	var card_effect = card_looking_for_target.card.effect
	if card_effect.target_type == 0:
		return

	if event is InputEventMouseMotion:
		var mouse_pos: Vector2 = event.position
		# Find hovered target by casting a ray
		var from: = camera.project_ray_origin(mouse_pos)
		var to: = from + camera.project_ray_normal(mouse_pos) * 400
		var intersected: = get_world().direct_space_state \
			.intersect_ray(from, to, [], card_effect.target_type, false, true)
		if intersected.has("collider"):
			card_target = intersected.collider.get_parent()
			if card_target is Tile:
				for tile in get_tree().get_nodes_in_group("tiles"):
					tile.highlighted = false
				card_target.highlighted = true
			else:
				card_target.highlighted = true
	detect_card_play()

func detect_card_play():
	if Input.is_action_just_released("interact"):
		print("You just played a card: ", card_looking_for_target.card.name, \
			" on ", card_target)
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
