extends CardPlayer
class_name Nomad

@export var card_scene: PackedScene

@onready var camera_target_pivot = $CameraTargetPivot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_dashboard.hand = [GameCards.TELEPORT, GameCards.TELEPORT, GameCards.SLASH, GameCards.REGENESIS]
#	card_dashboard.hand = ["Test card 1"]

func _process(_delta: float) -> void:
	camera_target_pivot.position = camera_target_pivot.position * 0.9
	if camera_target_pivot.position.length_squared() < 0.0001:
		camera_target_pivot.position = Vector3.ZERO

func set_coordinates(c: Vector2i) -> void:
	var prev_cam_target_pos = camera_target_pivot.global_position
	super.set_coordinates(c)
	camera_target_pivot.global_position = prev_cam_target_pos 
