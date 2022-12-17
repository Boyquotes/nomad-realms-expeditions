extends Actor
class_name TreeActor

func _ready():
	$MeshPivot.rotate_y(randf_range(0, 2 * PI))

func set_highlighted(h: bool) -> void:
	super.set_highlighted(h)
	
