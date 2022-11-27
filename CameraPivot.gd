extends Position3D

export var lerpSpeed: = 0.5

onready var camera_target: Spatial = $"../Actors/Nomad/CameraTargetPivot/CameraTarget"


func _ready() -> void:
	translation = camera_target.global_translation
	rotation = camera_target.global_rotation

func _process(_delta: float) -> void:
	var target_pos: Vector3 = camera_target.global_translation
	translation = translation + (target_pos - translation) * lerpSpeed
	
	var target_quat = Quat(camera_target.global_rotation)
	var quat = Quat(transform.basis)
	transform.basis = Basis(quat.slerp(target_quat, lerpSpeed))
