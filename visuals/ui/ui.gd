extends SubViewportContainer

signal card_looking_for_target(card)
signal card_not_looking_for_target(card)

func _on_card_dashboard_gui_card_looking_for_target(card):
	emit_signal("card_looking_for_target", card)

func _on_card_dashboard_gui_card_not_looking_for_target(card):
	emit_signal("card_not_looking_for_target", card)
