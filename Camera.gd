extends Camera3D

@export var lerpSpeed: = 1

@export var actor_to_follow: Node3D
@onready var camera_target = actor_to_follow.get_node("CameraTargetPivot/CameraTarget")

func _ready() -> void:
	position = camera_target.global_position
	rotation = camera_target.global_rotation

func _process(_delta: float) -> void:
	var target_pos: Vector3 = camera_target.global_position
	position = position + (target_pos - position) * lerpSpeed
	rotation = camera_target.global_rotation

