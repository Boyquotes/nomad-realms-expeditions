extends CardEffect
class_name TeleportEffect

func _handle(actor: Actor, target: Actor) -> void:
	assert(target, "No target to teleport to!")
	actor.world_pos = target.world_pos
