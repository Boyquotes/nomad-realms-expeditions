signal card_looking_for_target(card)
signal card_not_looking_for_target(card)

extends Node2D
class_name UICardDashBoard

onready var card_hand = $UICardHand
var hovered_card: WorldCard
var dragged_card: WorldCard

var card_looking_for_target: bool = false

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
		get_tree().set_input_as_handled()
	else:
		if hovered_card != null:
			hovered_card._unhover()
			hovered_card = null

func detect_drag_and_release():
	if Input.is_action_just_pressed("interact"):
		if hovered_card != null:
			dragged_card = hovered_card
			dragged_card.dragged = true
			get_tree().set_input_as_handled()
	elif Input.is_action_just_released("interact"):
		if card_looking_for_target:
			# The actual playing of the card, and the card's effects, are
			# handled by GameInput
			return
		if dragged_card != null:
			dragged_card.dragged = false
			dragged_card._unhover()
			dragged_card = null
			hovered_card = null

func get_hovered_card(event: InputEvent) -> WorldCard:
	var collided_areas = get_world_2d().direct_space_state \
		.intersect_point(event.position, 5, [], 0x1, false, true)
	if collided_areas.size() > 0:
		collided_areas.sort_custom(self, "_sort_by_tree_order")
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

func _on_PlayZone_mouse_entered() -> void:
	if dragged_card != null:
		card_looking_for_target = true
		emit_signal("card_looking_for_target", dragged_card)
		dragged_card.visible = false
		# Play an animation on the card I guess?

func _on_PlayZone_mouse_exited() -> void:
	if dragged_card != null:
		card_looking_for_target = false
		emit_signal("card_not_looking_for_target", dragged_card)
		dragged_card.visible = true
		# Play an animation on the card I guess?

func card_played_cleanup() -> void:
	card_hand.cards.remove(card_hand.cards.find(dragged_card))
	hovered_card = null
	dragged_card = null
	card_looking_for_target = false
