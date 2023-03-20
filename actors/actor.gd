extends Node3D
class_name Actor

signal world_pos_changed(old, new)

var highlight_flash_material: ShaderMaterial = preload("res://visuals/shaders/highlight_flash.tres")

@export var mesh_path: String
var mesh: MeshInstance3D

@export var card_player_component: CardPlayerComponent
@export var health_component: HealthComponent
@export var inventory_component: InventoryComponent

var world_pos: WorldPos = WorldPos.new(0, 0, 0, 0) : set = _set_world_pos

func _ready():
	mesh = get_node(mesh_path)

func _set_world_pos(pos: WorldPos):
	if !world_pos.equals(pos):
		emit_signal('world_pos_changed', world_pos, pos)
	world_pos = pos
	
	var tx: = pos.tile_pos.x
	var ty: = pos.tile_pos.y
	var net_x: int = pos.chunk_pos.x * 16 + tx
	var net_y: int = pos.chunk_pos.y * 16 + ty
	
	position.x = 1.5 * net_x
	# Offset y by half a tile if x is odd
	position.z = sqrt(3) * (net_y + 0.5 * (tx % 2))

func set_highlighted(h: bool) -> void:
	mesh.material_overlay = highlight_flash_material if h else null
