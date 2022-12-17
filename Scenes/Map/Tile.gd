extends GameObject
class_name Tile

@export var highlight_material: Material
@export var default_material: Material

const TILE_MAX_HEIGHT: = 5
const TILE_HEIGHT_SCALE: = 0.2

var height: int
var highlighted: = false : set = set_highlighted

@onready var hexagon: MeshInstance3D = $Hexagon

func initialize(x: int, z: int, color: Color) -> void:
	self.coordinates = Vector2i(x, z)
	height = randi() % TILE_MAX_HEIGHT + 1
	scale.y = height * TILE_HEIGHT_SCALE
	
#	set_color(Color(0, 1, 0))

func set_color(color: Color) -> void:
	var material: = hexagon.get_surface_override_material(0)
	material.albedo_color = color
	hexagon.set_surface_override_material(0, material)
	
func set_highlighted(h) -> void:
	if h:
		hexagon.set_surface_override_material(0, highlight_material)
	else:
		hexagon.set_surface_override_material(0, default_material)
	highlighted = h
