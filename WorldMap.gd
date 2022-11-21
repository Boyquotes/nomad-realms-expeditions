extends Spatial

export (PackedScene) var tile_scene
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for z in range(16):
		for x in range(16):
			var tile: Spatial = tile_scene.instance()
			var tile_pos: Vector2
			tile.translation.x = 1.5 * x
			tile.translation.y = rand_range(0, 1)
			tile.translation.z = sqrt(3) * z
			if x % 2 == 1:
				tile.translation.z += sqrt(3) * 0.5
			
			add_child(tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
