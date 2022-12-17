extends Marker3D

@export var lerpSpeed: = .8

@onready var nomad: Node3D = $"../Actors/Nomad"
@onready var camera_target: Node3D = $"../Actors/Nomad/CameraTargetPivot/CameraTarget"


func _ready() -> void:
	position = camera_target.global_position
	rotation = camera_target.global_rotation

func _process(_delta: float) -> void:
	var target_pos: Vector3 = camera_target.global_position
	position = position + (target_pos - position) * lerpSpeed
	
#	look_at(nomad.position, Vector3.UP)
	rotation = Quaternion(basis).slerp(Quaternion(camera_target.global_transform.basis), .9).get_euler()

