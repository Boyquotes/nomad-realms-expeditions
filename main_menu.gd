extends Control

@export var game_scene: PackedScene

var transitioned: = false

func _unhandled_input(event):
	if not transitioned && Input.is_action_just_released("interact"):
		var game: = game_scene.instantiate()
		get_tree().root.add_child(game)
		queue_free()
		visible = false
		get_viewport().set_input_as_handled()
		transitioned = true
