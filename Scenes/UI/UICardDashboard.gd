extends Node2D
class_name UICardDashBoard

signal card_looking_for_target(card)
signal card_not_looking_for_target(card)

@export var world_card_scene: PackedScene

@export var bound_actor: Actor : set = set_bound_actor

@onready var card_hand: UICardHand = $UICardHand
var hovered_card: WorldCard
var dragged_card: WorldCard

# Whether or not the card is dragged over the PlayZone
var is_card_looking_for_target: bool = false

func set_bound_actor(actor: Actor) -> void:
	bound_actor = actor
	if actor == null:
		return
	card_hand.delete_all_cards()
	for game_card in actor.card_player_component.hand:
		var world_card: WorldCard = world_card_scene.instantiate()
		world_card.init(game_card)
		card_hand.add_card(world_card)

func reset_target_positions() -> void:
	card_hand.reset_target_positions()

func _unhandled_input(event: InputEvent) -> void:
	detect_drag_and_release()
	if event is InputEventMouseMotion:
		detect_hover(event)

func detect_hover(event: InputEventMouseMotion):
	if dragged_card != null:
		return
		
	var card: WorldCard = get_hovered_card(event)
	if card != null:
		if hovered_card != null:
			hovered_card._unhover()
		if !card.hovered:
			card._hover()
		hovered_card = card
		get_viewport().set_input_as_handled()
	else:
		if hovered_card != null:
			hovered_card._unhover()
			hovered_card = null

func detect_drag_and_release():
	if Input.is_action_just_pressed("interact"):
		if hovered_card != null:
			dragged_card = hovered_card
			dragged_card.dragged = true
		get_viewport().set_input_as_handled()
	elif Input.is_action_just_released("interact"):
		if is_card_looking_for_target:
			# The actual playing of the card, and the card's effects, are
			# handled by Game.gd
			return
		if dragged_card != null:
			dragged_card.dragged = false
			dragged_card._unhover()
			dragged_card = null
			hovered_card = null

func get_hovered_card(event: InputEvent) -> WorldCard:
	var params: = PhysicsPointQueryParameters2D.new()
	params.collide_with_areas = true
	params.collide_with_bodies = false
	params.collision_mask = 0x1
	params.position = event.position
	var collided_areas = get_world_2d().direct_space_state.intersect_point(params, 5)
	if collided_areas.size() > 0:
		collided_areas.sort_custom(Callable(self,"_sort_by_tree_order"))
		return collided_areas[0].collider.get_parent() as WorldCard
	return null

func _sort_by_tree_order(a, b):
	var card_a: = a.collider.get_parent() as WorldCard
	var card_b: = b.collider.get_parent() as WorldCard
	if card_a.hovered:
		return true
	elif card_b.hovered:
		return false
	return card_a.get_index() > card_b.get_index()

# When card is dragged into the PlayZone, we interpret that as wanting to look
# for a target
func _on_PlayZone_mouse_entered() -> void:
	if dragged_card != null:
		is_card_looking_for_target = true
		emit_signal("card_looking_for_target", dragged_card)
		# If it requires a target, make the card disappear
		if dragged_card.card.effect.target_type != 0:
			# TODO: play an animation checked the card
			dragged_card.visible = false

# When card is dragged out of the RetainZone (which is a bit larget than the
# PlayZone!), we interpret that as cancelling the card.
func _on_RetainZone_mouse_exited():
	if dragged_card != null:
		is_card_looking_for_target = false
		emit_signal("card_not_looking_for_target", dragged_card)
		dragged_card.visible = true
		# Play an animation checked the card I guess?

func card_played_cleanup() -> void:
	card_hand.cards.remove_at(card_hand.cards.find(dragged_card))
	hovered_card = null
	dragged_card = null
	is_card_looking_for_target = false
	reset_target_positions()

func _on_bound_actor_card_drawn(numDrawn: int) -> void:
	pass
