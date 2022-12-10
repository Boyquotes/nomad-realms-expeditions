signal card_looking_for_target(card)
signal card_not_looking_for_target(card)

extends Node2D
class_name UI

onready var card_dashboard: UICardDashBoard = $UICardDashboard

func reset_target_positions() -> void:
	card_dashboard.reset_target_positions()

func _on_UICardDashboard_card_looking_for_target(card) -> void:
	emit_signal("card_looking_for_target", card)

func _on_UICardDashboard_card_not_looking_for_target(card) -> void:
	emit_signal("card_not_looking_for_target", card)
