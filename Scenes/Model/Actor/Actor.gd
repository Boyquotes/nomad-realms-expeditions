extends Node3D
class_name Actor

var highlight_flash_material: ShaderMaterial = preload("res://Assets/3D/highlight_flash.tres")

@export var mesh_path: String
@export var health_component: HealthComponent
@export var card_player_component: CardPlayerComponent

var id: int
var world_pos: WorldPos : set = set_world_pos
var highlighted: = false : set = set_highlighted
var mesh: MeshInstance3D

func _ready():
	add_to_group("actors")
	mesh = get_node(mesh_path)

# TODO: have event queue parameter
func update() -> void:
	pass

func set_highlighted(h: bool) -> void:
	highlighted = h
	if h:
		mesh.material_overlay = highlight_flash_material
	else:
		mesh.material_overlay = null

func die():
	queue_free()
	visible = false

func copy_to(object):
	object.highlighted = highlighted

func set_world_pos(pos: WorldPos) -> void:
	world_pos = pos
	var tx: = pos.tile_pos.x
	var ty: = pos.tile_pos.y
	var net_x: int = pos.chunk_pos.x * 16 + tx
	var net_y: int = pos.chunk_pos.y * 16 + ty
	
	position.x = 1.5 * net_x
	# Offset y by half a tile if x is odd
	position.z = sqrt(3) * (net_y + 0.5 * (tx % 2))
