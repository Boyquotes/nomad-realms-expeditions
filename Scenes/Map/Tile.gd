extends Node3D
class_name Tile

@export var highlight_material: Material
@export var default_material: Material

const TILE_MAX_HEIGHT: = 5
const TILE_HEIGHT_SCALE: = 0.2

var coordinates: Vector2
var height: int
var highlighted: = false : set = set_highlighted

@onready var hexagon: MeshInstance3D = $Hexagon

func initialize(x: int, z: int, color: Color) -> void:
	coordinates = Vector2(x, z)
	position.x = 1.5 * x
	height = randi() % TILE_MAX_HEIGHT + 1
#	height = 1
	scale.y = height * TILE_HEIGHT_SCALE
	position.z = sqrt(3) * z
	if x % 2 == 1:
		position.z += sqrt(3) * 0.5
	
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
