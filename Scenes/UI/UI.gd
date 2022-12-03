extends Node2D

onready var card_dashboard: UICardDashBoard = $UICardDashboard

func reset_target_positions() -> void:
	card_dashboard.reset_target_positions()
	
