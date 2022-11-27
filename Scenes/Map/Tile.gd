extends Spatial
class_name Tile

const TILE_MAX_HEIGHT: = 5
const TILE_HEIGHT_SCALE: = 0.4

var position: Vector2
var height: int

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
	var material: = ($Hexagon as MeshInstance).get_surface_material(0)
	material.albedo_color = color
	$Hexagon.set_surface_material(0, material)
