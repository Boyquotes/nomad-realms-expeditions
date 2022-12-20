extends HealthActor
class_name TreeActor

@export var highlight_flash: ShaderMaterial

@onready var tree_mesh = $MeshPivot/tree/Tree

func _ready():
	$MeshPivot.rotate_y(randf_range(0, 2 * PI))
	health = 2

func set_highlighted(h: bool) -> void:
	super.set_highlighted(h)
	if h:
		tree_mesh.material_overlay = highlight_flash
	else:
		tree_mesh.material_overlay = null
