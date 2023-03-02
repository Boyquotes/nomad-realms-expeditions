extends Camera3D

@export var lerpSpeed: = 1

@export var camera_pivot: CameraPivot

func _ready() -> void:
	position = camera_pivot.target.global_position
	rotation = camera_pivot.target.global_rotation

func _process(_delta: float) -> void:
	var target_pos: Vector3 = camera_pivot.target.global_position
	position = position + (target_pos - position) * lerpSpeed
	rotation = camera_pivot.global_rotation
