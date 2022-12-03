extends Node2D
class_name UICardDashBoard

onready var card_hand = $UICardHand
var hovered_card: WorldCard
var dragged_card: WorldCard

func reset_target_positions() -> void:
	card_hand.reset_target_positions()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		detect_hover(event)
	detect_drag_and_release()

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
	elif Input.is_action_just_released("interact"):
		# TODO play cards
		if dragged_card != null:
			dragged_card.dragged = false
			dragged_card._unhover()
			dragged_card = null

func get_hovered_card(event: InputEvent) -> WorldCard:
	var collided_areas = get_world_2d().direct_space_state \
		.intersect_point(event.position, 5, [], 0x7FFFFFFF, false, true)
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
