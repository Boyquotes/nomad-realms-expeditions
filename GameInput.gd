extends Node
class_name GameInput


var card_looking_for_target: GameCardGui
var ui_card_dashboard: UICardDashBoard

func init(context_queues: ContextQueues) -> void:
	ui_card_dashboard = $"../UI".card_dashboard

func _unhandled_input(event: InputEvent) -> void:
	if card_looking_for_target == null:
		return
	if event is InputEventMouseMotion:
		var mouse_pos: Vector2 = event.position
		# Find hovered target
	detect_card_play()

func detect_card_play():
	if Input.is_action_just_released("interact"):
		print("You just played a card: ", card_looking_for_target.card.name)
		card_looking_for_target.free()
		card_looking_for_target = null
		ui_card_dashboard.card_played_cleanup()

func _on_UI_card_looking_for_target(card: GameCardGui) -> void:
	card_looking_for_target = card

func _on_UI_card_not_looking_for_target(card: GameCardGui) -> void:
	card_looking_for_target = null
