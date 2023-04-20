extends Node3D
class_name Actor

signal world_pos_changed(old, new)

var highlight_flash_material: ShaderMaterial = preload("res://visuals/shaders/highlight_flash.tres")

@export var mesh: MeshInstance3D
@export var collision_body: StaticBody3D

@export_group("Components")
@export var ai_component: AiComponent
@export var card_player_component: CardPlayerComponent
@export var health_component: HealthComponent
@export var inventory_component: InventoryComponent

var world_pos: WorldPos = WorldPos.new(0, 0) : set = _set_world_pos

func _enter_tree():
	add_to_group("actors")

func _ready():
	pass

func _set_world_pos(pos: WorldPos):
	if !world_pos.equals(pos):
		emit_signal('world_pos_changed', world_pos, pos)
	
	if not _is_tile():
		# Change position in world map
		Global.world_map.actors[world_pos.tile_pos.y][world_pos.tile_pos.x] = null
		Global.world_map.actors[pos.tile_pos.y][pos.tile_pos.x] = self
	
	world_pos = pos
	
	var tx: = pos.tile_pos.x
	var ty: = pos.tile_pos.y
	
	position.x = 1.5 * tx
	# Offset z by half a tile if x is odd
	position.z = sqrt(3) * (ty + 0.5 * (tx % 2))

func get_neutrality_tags() -> int:
	return collision_body.collision_layer

func serialize() -> int:
	var cpc: = card_player_component.serialize() # 64 * 64 bits
	var hc: = health_component.serialize() # 64 bits
	# var ic: = inventory_component.serialize() # Not used
	var wp: = world_pos.serialize() # 128
	return cpc << 64 | hc << 32 || wp

func is_an_enemy_to(other: Actor) -> bool:
	var neutr: = get_neutrality_tags()
	var other_neutr: = other.get_neutrality_tags()
	if neutr == other_neutr:
		return false
	if neutr & 0b1000 > 0 or other_neutr & 0b1000 > 0:
		return false
	if neutr & other_neutr > 0:
		return false
	return true

func set_highlighted(h: bool) -> void:
	mesh.material_overlay = highlight_flash_material if h else null

func _exit_tree():
	remove_from_group("actors")

func _is_tile() -> bool:
	return false

