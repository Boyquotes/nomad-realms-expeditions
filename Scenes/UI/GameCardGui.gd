extends Node2D
class_name GameCardGui

var target_scale: = 1.0
var target_position: Vector2

var hovered: = false
var dragged: = false

func _process(delta: float) -> void:
	scale *= (target_scale / scale.x - 1) * 0.2 + 1
	if dragged:
		position.x += (get_global_mouse_position().x - position.x) * 0.7
		position.y += (get_global_mouse_position().y - position.y) * 0.7
	else:
		var current_target_pos: = target_position
		if hovered && !dragged:
			current_target_pos.y -= 80
		position.x += (current_target_pos.x - position.x) * 0.2
		position.y += (current_target_pos.y - position.y) * 0.2

func _hover() -> void:
	target_scale = 1.1
	hovered = true
	z_index = 1

func _unhover() -> void:
	target_scale = 1
	hovered = false
	z_index = 0

#func _unhandled_input(event: InputEvent):
#	if hovered and event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
#			dragged = true
#			get_tree().set_input_as_handled()
#		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
#			dragged = false
#			get_tree().set_input_as_handled()
