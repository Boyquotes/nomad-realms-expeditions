extends Node3D
class_name CardGui

var card_instance: CardInstance : set = _set_card

@onready var texture: = $Texture
@onready var title_label: = $TitleLabel
@onready var text_label: = $TextLabel

var hovered: = false
var dragged: = false
var target_position: Vector3 = Vector3.ZERO
var target_rotation: Quaternion = Quaternion.IDENTITY
var target_scale: = 1.0

func _process(delta: float) -> void:
	scale *= (target_scale / scale.x - 1) * 0.5 + 1
	if !dragged:
		position = position.lerp(target_position, 0.3)
	rotation = transform.basis.get_rotation_quaternion().slerp(target_rotation, 0.45).get_euler()

func _set_card(c: CardInstance) -> void:
	card_instance = c
	if c.card.texture:
		texture.texture = c.card.texture
	title_label.text = c.card.name
	text_label.text = c.card.text

func hover() -> void:
	target_scale = 1.1
	hovered = true
	target_position.y += 0.15
	target_position.z += 0.1

func unhover() -> void:
	target_scale = 1.0
	hovered = false
	target_position.y -= 0.15
	target_position.z -= 0.1
