extends Position3D

# TODO: Extract all sensitivity to a settings class
export var mouse_sensitivity: = 0.15
export var scroll_sensitivity: = 2

onready var camera_target: Spatial = $CameraTarget

func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				camera_target.translation.z *= pow(0.9, scroll_sensitivity)
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				camera_target.translation.z *= 1 / pow(0.9, scroll_sensitivity)
			camera_target.translation.z = clamp(camera_target.translation.z, 2, 20)
	elif event is InputEventMouseMotion and Input.is_action_pressed("rotate_camera"):
		rotation.x += deg2rad(-event.relative.y * mouse_sensitivity)
		rotation.x = clamp(rotation.x, -PI / 2, -deg2rad(10))
		rotation.y += deg2rad(-event.relative.x * mouse_sensitivity)
		
