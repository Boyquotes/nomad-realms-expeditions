extends Actor
class_name Nomad

@onready var camera_target_pivot: Marker3D = $CameraTargetPivot
@onready var camera_target: Marker3D = $CameraTargetPivot/CameraTarget

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	card_dashboard.hand = [GameCards.TELEPORT, GameCards.TELEPORT, GameCards.SLASH, GameCards.REGENESIS]
#	health = 20

func _process(_delta: float) -> void:
	look_at(camera_target.global_position, Vector3.UP)
	rotation.x = 0
	rotation.y += PI
	camera_target_pivot.position = camera_target_pivot.position * 0.9
	if camera_target_pivot.position.length_squared() < 0.0001:
		camera_target_pivot.position = Vector3.ZERO

func set_world_pos(pos: WorldPos) -> void:
	if is_inside_tree():
		var prev_cam_target_pos = camera_target_pivot.global_position
		super.set_world_pos(pos)
		camera_target_pivot.global_position = prev_cam_target_pos
	else:
		super.set_world_pos(pos)

