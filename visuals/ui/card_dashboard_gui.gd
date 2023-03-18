extends Node3D
class_name CardDashboardGui

signal set_card_gui_looking_for_target(card_gui)

@export var camera: Camera3D
@export var card_gui_scene: PackedScene

var bound_actor: Actor : set = _set_bound_actor

var card_guis: Array[CardGui] = []

var hovered_card_gui: CardGui
var dragged_card_gui: CardGui

# Whether or not the card is dragged over the PlayZone
var is_card_gui_looking_for_target: bool = false

func _unhandled_input(event: InputEvent) -> void:
	detect_drag_and_release()
	if event is InputEventMouseMotion:
		detect_hover(event)

func detect_hover(event: InputEventMouseMotion):
	if dragged_card_gui != null:
		return
		
	var card: CardGui = get_hovered_card_gui(event)
	if card != null:
		if hovered_card_gui != null:
			hovered_card_gui.unhover()
		if !card.hovered:
			card.hover()
		hovered_card_gui = card
		get_viewport().set_input_as_handled()
	else:
		if hovered_card_gui != null:
			hovered_card_gui.unhover()
			hovered_card_gui = null

func detect_drag_and_release():
	if Input.is_action_just_pressed("interact"):
		if hovered_card_gui != null:
			dragged_card_gui = hovered_card_gui
			dragged_card_gui.dragged = true
		get_viewport().set_input_as_handled()
	elif Input.is_action_just_released("interact"):
		if is_card_gui_looking_for_target:
			# The actual playing of the card, and the card's effects, are
			# handled by game.gd
			return
		if dragged_card_gui != null:
			dragged_card_gui.dragged = false
			dragged_card_gui.unhover()
			dragged_card_gui = null
			hovered_card_gui = null

func get_hovered_card_gui(event: InputEvent) -> CardGui:
	var mouse_pos: Vector2 = event.position
	var params: = PhysicsRayQueryParameters3D.new()
	var from: = camera.project_ray_origin(mouse_pos)
	var to: = from + camera.project_ray_normal(mouse_pos) * 400
	params.from = from
	params.to = to
	params.collision_mask = 0x10000 # Important!
	params.collide_with_areas = true
	params.collide_with_bodies = false
	var collided_area: = get_world_3d().direct_space_state.intersect_ray(params)
	if "collider" in collided_area:
		return collided_area.collider.get_parent() as CardGui
	return null

# When card is dragged into the PlayArea, we interpret that as wanting to look
# for a target
func _on_play_area_mouse_entered():
	if dragged_card_gui != null:
		is_card_gui_looking_for_target = true
		emit_signal("set_card_gui_looking_for_target", dragged_card_gui)
		# If it requires a target, make the card disappear
		if dragged_card_gui.card.effect.target_type != 0:
			# TODO: play an animation checked the card
			dragged_card_gui.visible = false

# When card is dragged out of the RetainArea (which is a bit larger than the
# PlayArea!), we interpret that as cancelling the card.
func _on_retain_area_mouse_exited():
	if dragged_card_gui != null:
		is_card_gui_looking_for_target = false
		emit_signal("set_card_gui_looking_for_target", null)
		dragged_card_gui.visible = true
		# Play an animation checked the card I guess?

func _set_bound_actor(a: Actor) -> void:
	bound_actor = a
	var card_player_component: = a.card_player_component
	for _card_gui in card_guis:
		var card_gui: CardGui = _card_gui
		card_gui.queue_free()
		card_gui.visible = false
	card_guis.clear()
	
	for card_instance in card_player_component.hand:
		var card_gui: CardGui = card_gui_scene.instantiate()
		card_guis.append(card_gui)
		add_child(card_gui)
		card_gui.card_instance = card_instance
	reset_card_gui_target_positions()

func reset_card_gui_target_positions() -> void:
	var hand_size: = len(card_guis)
	for i in range(hand_size):
		card_guis[i].target_position = Vector3(1.0 * i / hand_size, 0.4, 0.2)

#func card_played_cleanup() -> void:
#	card_hand.cards.remove_at(card_hand.cards.find(dragged_card_gui))
#	hovered_card_gui = null
#	dragged_card_gui = null
#	is_card_gui_looking_for_target = false
#	reset_target_positions()
