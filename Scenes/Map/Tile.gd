extends Actor
class_name Tile

const TILE_MAX_HEIGHT: = 5
const TILE_HEIGHT_SCALE: = 0.2

var height: int

@onready var hexagon: MeshInstance3D = $Hexagon

func initialize(x: int, z: int, h: int, color: Color) -> void:
	self.world_pos = WorldPos.new(0, 0, x, z)
	height = h
	scale.y = height * TILE_HEIGHT_SCALE
	
#	set_color(Color(0, 1, 0))

func set_color(color: Color) -> void:
	var material: = hexagon.get_surface_override_material(0)
	material.albedo_color = color
	hexagon.set_surface_override_material(0, material)

