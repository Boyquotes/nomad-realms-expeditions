extends Spatial
class_name Tile

export(Material) var highlight_material
export(Material) var default_material

const TILE_MAX_HEIGHT: = 5
const TILE_HEIGHT_SCALE: = 0.4

var position: Vector2
var height: int
var highlighted: = false setget set_highlighted

onready var hexagon: MeshInstance = $Hexagon

func initialize(x: int, z: int, color: Color) -> void:
	position = Vector2(x, z)
	translation.x = 1.5 * x
	height = randi() % TILE_MAX_HEIGHT + 1
#	height = 1
	scale.y = height * TILE_HEIGHT_SCALE
	translation.z = sqrt(3) * z
	if x % 2 == 1:
		translation.z += sqrt(3) * 0.5
	
#	set_color(Color(0, 1, 0))

func set_color(color: Color) -> void:
	var material: = hexagon.get_surface_material(0)
	material.albedo_color = color
	hexagon.set_surface_material(0, material)
	
func set_highlighted(h) -> void:
	if h:
		hexagon.set_surface_material(0, highlight_material)
	else:
		hexagon.set_surface_material(0, default_material)
	highlighted = h
