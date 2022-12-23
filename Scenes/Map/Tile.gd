extends GameObject
class_name Tile

@export var highlight_material: Material

const TILE_MAX_HEIGHT: = 5
const TILE_HEIGHT_SCALE: = 0.2

var height: int
var highlighted: = false : set = set_highlighted

@onready var hexagon: MeshInstance3D = $Hexagon

func initialize(x: int, z: int, h: int, color: Color) -> void:
	self.coordinates = Vector2i(x, z)
	height = h
	scale.y = height * TILE_HEIGHT_SCALE
	
#	set_color(Color(0, 1, 0))

func set_color(color: Color) -> void:
	var material: = hexagon.get_surface_override_material(0)
	material.albedo_color = color
	hexagon.set_surface_override_material(0, material)
	
func set_highlighted(h) -> void:
	highlighted = h
	if h:
		hexagon.material_overlay = highlight_material
	else:
		hexagon.material_overlay = null
