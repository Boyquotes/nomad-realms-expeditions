extends HealthActor
class_name CardPlayer

var card_dashboard: = CardDashboard.new()

func _ready():
	add_to_group("card_players")

func copy_to(object) -> void:
	object.card_dashboard = card_dashboard.copy()
	super.copy_to(object)
