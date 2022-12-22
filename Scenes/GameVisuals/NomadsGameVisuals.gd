extends Node
class_name NomadsGameVisuals

var context_queues: ContextQueues

@export var card_scene: PackedScene

@onready var player: Nomad = $"../Actors/Nomad"
@onready var ui_card_dashboard: Node2D = $"../UICardDashboard"

func init(context_queues: ContextQueues) -> void:
	self.context_queues = context_queues
	var dashboard: = player.card_dashboard
	for i in range(len(dashboard.hand)):
		create_card_gui(dashboard.hand[i])
	ui_card_dashboard.reset_target_positions()
	for i in range(ui_card_dashboard.card_hand.cards.size()):
		var card: WorldCard = ui_card_dashboard.card_hand.cards[i]
		card.position = card.target_position
		card.position.y += 40
		
func create_card_gui(card: GameCard) -> void:
	var card_node: WorldCard = card_scene.instantiate()
	card_node.init(card)
	ui_card_dashboard.card_hand.add_card(card_node)

func _process(delta: float) -> void:
	if len(context_queues.logic_to_visuals) > 0:
		var event = context_queues.logic_to_visuals.pop_front()
		# TODO: Handle event
