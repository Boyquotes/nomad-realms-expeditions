extends Actor

func _ready():
	super()
	world_pos = WorldPos.new(0, 0, 8, 8)

func _on_health_component_health_depleted():
	queue_free()
	visible = false
