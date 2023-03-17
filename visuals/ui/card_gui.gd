extends Node3D
class_name CardGui

var card_instance: CardInstance : set = _set_card

@onready var texture: = $Texture
@onready var title_label: = $TitleLabel
@onready var text_label: = $TextLabel

var hovered: = false
var dragged: = false
var target_scale: = 1.0

func _process(delta: float) -> void:
	scale *= (target_scale / scale.x - 1) * 0.5 + 1

func _set_card(c: CardInstance) -> void:
	card_instance = c
	texture.texture = c.card.texture
	title_label.text = c.card.name
	text_label.text = c.card.text

func hover() -> void:
	target_scale = 1.1
	hovered = true

func unhover() -> void:
	target_scale = 1.0
	hovered = false
