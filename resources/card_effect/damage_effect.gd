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
	
	var num_enemies: = 0
	var total_enemy_health: = 0
	
	var total_friendlies: = 0
	
	if surroundings:
		for i in range(surroundings.size()):
			for j in range(surroundings[i].size()):
				var a: Actor = surroundings[i][j]
				if not a or not a.health_component:
					continue
				if player.is_an_enemy_to(a):
					num_enemies += 1
					total_enemy_health += a.health_component.health
				else:
					total_friendlies += 1
	
	if num_enemies == 0:
		return 0
	
	# If you can one-hit kill
	if num_enemies == 1 and total_enemy_health <= damage:
		return 1
	
	var avg_enemy_health: float = 1.0 * total_enemy_health / num_enemies
	
	if avg_enemy_health < damage:
		return 1.0 / num_enemies
	
	return damage / avg_enemy_health
