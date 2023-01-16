extends Control

func _unhandled_input(event):
	if event is InputEventMouseButton:
		var mouse_button_event: InputEventMouseButton = event
		if mouse_button_event.button_index == MOUSE_BUTTON_LEFT:
			# TODO: transition to game
			pass
