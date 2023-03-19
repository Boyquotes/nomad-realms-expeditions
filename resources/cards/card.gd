extends Resource
class_name Card

@export var name: StringName
# Texture should be 256 x 336 pixels
@export var texture: Texture2D
@export_flags_3d_physics var target_type: int
@export var card_effect: CardEffect
@export var text: String
@export_range(0, 10) var cooldown: int = 1
@export_range(0, 4) var rarity: int = 0
