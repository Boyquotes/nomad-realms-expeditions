extends Spatial

var context_queues: ContextQueues

export (PackedScene) var card_scene

onready var player: Nomad = $"../Actors/Nomad"
onready var ui: Control = $"../UI"
onready var ui_card_hand: Control = $"../UI/CardHand"

func init(context_queues: ContextQueues) -> void:
	self.context_queues = context_queues

func _ready() -> void:
	var dashboard: = player.card_dashboard
	for i in range(len(dashboard.hand)):
		create_card_gui(dashboard.hand[i])
	ui.reset_target_positions()
	for i in range(ui_card_hand.cards.size()):
		var card: Card = ui_card_hand.cards[i]
		card.margin_left = card.target_position.x
		card.margin_top = card.target_position.y + 40
	print(":KJAOFIHPOAHIPRHPhi")
		
func create_card_gui(card: String) -> void:
	var card_node: Card = card_scene.instance()
	card_node.init(card)
	ui_card_hand.add_card(card_node)
	print("Created card " + card)

func _process(delta: float) -> void:
	if len(context_queues.logic_to_visuals) > 0:
		var event = context_queues.logic_to_visuals.pop_front()
		# TODO: Handle event
