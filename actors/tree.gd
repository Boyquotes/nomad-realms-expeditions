extends Actor


func _on_health_component_health_depleted():
	queue_free()
	visible = false
