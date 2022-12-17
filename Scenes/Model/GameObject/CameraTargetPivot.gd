extends Marker3D

# TODO: Extract all sensitivity to a settings class
@export var mouse_sensitivity: = 0.15
@export var scroll_sensitivity: = 2

@onready var camera_target: Node3D = $CameraTarget

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				camera_target.position.z *= pow(0.9, scroll_sensitivity)
			# zoom out
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				camera_target.position.z *= 1 / pow(0.9, scroll_sensitivity)
			camera_target.position.z = clamp(camera_target.position.z, 5, 20)
	elif event is InputEventMouseMotion and Input.is_action_pressed("rotate_camera"):
		rotation.x += deg_to_rad(-event.relative.y * mouse_sensitivity)
		rotation.x = clamp(rotation.x, -deg_to_rad(60), -deg_to_rad(10))
		rotation.y += deg_to_rad(-event.relative.x * mouse_sensitivity)
		
