extends Actor
class_name Tile

enum Type {GRASS}

var type: Type = Type.GRASS :
	set(new_type):
		type = new_type

func _ready():
	var mat: StandardMaterial3D = mesh.material_override

# Override
func _is_tile() -> bool:
	return true
