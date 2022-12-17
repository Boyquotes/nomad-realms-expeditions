extends Node3D
class_name GameObject

var id: int

var coordinates: Vector2i : set = set_coordinates

func set_coordinates(c: Vector2i) -> void:
	coordinates = c
	position.x = 1.5 * c.x
	# Offset y by half a tile if x is odd
	position.z = sqrt(3) * c.y + (sqrt(3) * 0.5 * (c.x % 2))
