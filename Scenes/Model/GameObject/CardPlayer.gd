extends HealthActor
class_name CardPlayer

var card_dashboard: = CardDashboard.new()

func _ready():
	add_to_group("card_players")
