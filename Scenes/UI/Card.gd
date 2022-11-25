signal card_released

extends Control
class_name Card

var target_scale = 1
var target_position: Vector2
var dragged: = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func reset_position(index: int, totalCards: int) -> void:
	if not dragged:
		target_position.x = 1.0 * (index + 0.5) / totalCards
		target_position.x += (0.5 - target_position.x) * 0.4
		target_position.y = 0.4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rect_scale *= (target_scale / rect_scale.x - 1) * 0.2 + 1
	if dragged:
		margin_left += (get_global_mouse_position().x - margin_left) * 0.7
		margin_top += (get_global_mouse_position().y - margin_top) * 0.7
		print()
#	else:
#		margin_left += (target_position.x - margin_top) * 0.2
#		margin_top += (target_position.y - margin_top) * 0.2

func _on_Card_mouse_entered() -> void:
	target_scale = 1.1

func _on_Card_mouse_exited() -> void:
	target_scale = 1

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			dragged = true
			print("Dragged " + str(dragged))
		elif event.button_index == BUTTON_LEFT and not event.pressed:
			dragged = false
			print("Dragged " + str(dragged))
