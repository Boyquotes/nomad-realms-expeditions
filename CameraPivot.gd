extends Marker3D

@export var lerpSpeed: = 1

var nomad: Node3D
var camera_target: Node3D

# Called by NomadsGameVisuals
func init() -> void:
	nomad = $"../Actors/Nomad"
	camera_target = $"../Actors/Nomad/CameraTargetPivot/CameraTarget"
	position = camera_target.global_position
	rotation = camera_target.global_rotation

func _process(_delta: float) -> void:
	var target_pos: Vector3 = camera_target.global_position
	position = position + (target_pos - position) * lerpSpeed
	
#	look_at(nomad.position, Vector3.UP)
	rotation = camera_target.global_rotation

