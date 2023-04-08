extends CardEffect
class_name DamageEffect

@export_range(0, 10000) var damage: int = 1

func _handle(actor: Actor, target: Actor) -> void:
	target.health_component.health -= damage

# Override
func calculate_playability(surroundings: Array[Array], player: Actor) -> float:
	var card_player_comp: = player.card_player_component
	var health_comp: = player.health_component
	var v: int = 0
	
	if surroundings:
		for i in range(surroundings.size()):
			for j in range(surroundings[i].size()):
				var a: Actor = surroundings[i][j]
				if not a or not a.health_component:
					continue
				if player.is_an_enemy_to(a):
					v -= a.health_component.health
				else:
					v += a.health_component.health
	
	if health_comp:
		v += health_comp.health / health_comp.starting_health
	if card_player_comp:
		v += card_player_comp.hand.size()
	
	return v
