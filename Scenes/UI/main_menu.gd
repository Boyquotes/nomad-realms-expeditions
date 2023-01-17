extends Control

@export var game_scene: PackedScene

@onready var click_to_start_label: Label = $ClickToStartLabel

func _unhandled_input(event):
	if event is InputEventMouseButton:
		var mouse_button_event: InputEventMouseButton = event
		if mouse_button_event.button_index == MOUSE_BUTTON_LEFT:
			queue_free()
			get_tree().root.add_child(game_scene.instantiate())
