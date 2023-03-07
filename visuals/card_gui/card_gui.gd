extends Node2D
class_name CardGui

var card_instance: CardInstance : set = _set_card

@onready var texture: = $Texture
@onready var text_label: = $TextLabel

func _set_card(c: CardInstance) -> void:
	card_instance = c
	texture.texture = c.card.texture
	text_label.text = c.card.text
