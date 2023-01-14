extends Node3D
class_name GameObject

var id: int

var world_pos: WorldPos : set = set_world_pos

func set_world_pos(pos: WorldPos) -> void:
	world_pos = pos
	var tx: = pos.tile_pos.x
	var ty: = pos.tile_pos.y
	var net_x: int = pos.chunk_pos.x * 16 + tx
	var net_y: int = pos.chunk_pos.y * 16 + ty
	
	position.x = 1.5 * net_x
	# Offset y by half a tile if x is odd
	position.z = sqrt(3) * (net_y + 0.5 * (tx % 2))

func generate_id() -> void:
	self.id = IdGenerator.generate_id()
