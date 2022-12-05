extends Spatial

var context_queues: ContextQueues

export (PackedScene) var card_scene

onready var player: Nomad = $"../Actors/Nomad"
onready var ui: Node2D = $"../UI"
onready var ui_card_hand: Node2D = $"../UI/UICardDashboard/UICardHand"

func init(context_queues: ContextQueues) -> void:
	self.context_queues = context_queues

func _ready() -> void:
	var dashboard: = player.card_dashboard
	for i in range(len(dashboard.hand)):
		create_card_gui(dashboard.hand[i])
	ui.reset_target_positions()
	for i in range(ui_card_hand.cards.size()):
		var card: WorldCard = ui_card_hand.cards[i]
		card.position = card.target_position
		card.position.y += 40
		
func create_card_gui(card: GameCard) -> void:
	var card_node: WorldCard = card_scene.instance()
	card_node.init(card)
	ui_card_hand.add_card(card_node)

func _process(delta: float) -> void:
	if len(context_queues.logic_to_visuals) > 0:
		var event = context_queues.logic_to_visuals.pop_front()
		# TODO: Handle event
