signal card_selected
signal card_played
signal card_cancelled

extends Node2D
class_name Card

var target_scale: = 1.0
var target_position: Vector2
var dragged: = false

var card_name: String

func init(card_name: String) -> void:
	self.card_name = card_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale *= (target_scale / scale.x - 1) * 0.2 + 1
	if dragged:
		position.x += (get_global_mouse_position().x - position.x) * 0.7
		position.y += (get_global_mouse_position().y - position.y) * 0.7
	else:
		position.x += (target_position.x - position.x) * 0.2
		position.y += (target_position.y - position.y) * 0.2

func _on_SelectBox_mouse_entered() -> void:
	target_scale = 1.1

func _on_SelectBox_mouse_exited() -> void:
	target_scale = 1

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			dragged = true
#			print("Dragged " + str(dragged))
		elif event.button_index == BUTTON_LEFT and not event.pressed:
			dragged = false
#			print("Dragged " + str(dragged))
