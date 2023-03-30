extends Control

@export var game_scene: PackedScene

func _input(event):
	if Input.is_action_just_released("interact"):
		var game: = game_scene.instantiate()
		get_tree().root.add_child(game)
		queue_free()
		visible = false
