extends Marker3D
class_name CameraPivot

@onready var target: Marker3D = $Target

# TODO: Extract all sensitivity to a settings class
@export var mouse_sensitivity: = 0.35
@export var scroll_sensitivity: = 1
@export var damping = 0.3

var scroll_velocity: float
var rotation_x_velocity: float
var rotation_y_velocity: float

func _process(delta):
	target.position.z *= pow(0.9, scroll_velocity)
	target.position.z = clamp(target.position.z, 5, 24)
	
	rotation.x += rotation_x_velocity
	rotation.x = clamp(rotation.x, -deg_to_rad(60), -deg_to_rad(10))
	rotation.y += rotation_y_velocity
	
	scroll_velocity *= 1 - damping
	rotation_x_velocity *= 1 - damping
	rotation_y_velocity *= 1 - damping

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				scroll_velocity = scroll_sensitivity
			# zoom out
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				scroll_velocity = -scroll_sensitivity
	elif event is InputEventMouseMotion and Input.is_action_pressed("rotate_camera"):
		rotation_x_velocity += deg_to_rad(-event.relative.y * mouse_sensitivity)
		rotation_y_velocity += deg_to_rad(-event.relative.x * mouse_sensitivity)
		
