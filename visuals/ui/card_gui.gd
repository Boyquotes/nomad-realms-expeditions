extends Node3D
class_name CardGui

var card_instance: CardInstance : set = _set_card

@onready var texture: = $Texture
@onready var title_label: = $TitleLabel
@onready var text_label: = $TextLabel

func _set_card(c: CardInstance) -> void:
	card_instance = c
	texture.texture = c.card.texture
	title_label.text = c.card.name
	text_label.text = c.card.text
