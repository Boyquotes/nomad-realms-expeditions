extends Spatial
class_name Actor

var highlighted: = false setget set_highlighted

func _ready():
	add_to_group("actors")

# TODO: have event queue parameter
func update() -> void:
	pass

func set_highlighted(h: bool) -> void:
	highlighted = h
