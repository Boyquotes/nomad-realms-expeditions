extends Control

var target_scale = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rect_scale *= (target_scale / rect_scale.x - 1) * 0.2 + 1

func _on_Card_mouse_entered() -> void:
	target_scale = 1.1

func _on_Card_mouse_exited() -> void:
	target_scale = 1
