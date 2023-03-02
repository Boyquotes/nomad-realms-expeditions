extends Resource
class_name WorldPos

@export var chunk_pos: Vector2i
@export var tile_pos: Vector2i

func _init(cx, cy, tx, ty):
	chunk_pos = Vector2i(cx, cy)
	tile_pos = Vector2i(tx, ty)

func shifted() -> bool:
	return tile_pos.x % 2 == 1

func distance_to(other: WorldPos) -> int:
	var diff: = other.tile_pos - tile_pos + (other.chunk_pos - chunk_pos) * 16
	var absDiffX: int = abs(diff.x)

	var yDiffAchievedGoingAlongX: int
	if shifted() == other.shifted():
		yDiffAchievedGoingAlongX = absDiffX / 2
	elif shifted():
		if diff.y < 0:
			yDiffAchievedGoingAlongX = absDiffX / 2
		else:
			yDiffAchievedGoingAlongX = (absDiffX + 1) / 2
	else:
		if diff.y < 0:
			yDiffAchievedGoingAlongX = (absDiffX + 1) / 2
		else:
			yDiffAchievedGoingAlongX = absDiffX / 2
	if yDiffAchievedGoingAlongX >= abs(diff.y):
		return absDiffX
	else:
		return absDiffX + abs(diff.y) - yDiffAchievedGoingAlongX

func equals(other: WorldPos) -> bool:
	return chunk_pos == other.chunk_pos && tile_pos == other.tile_pos

func _to_string():
	return "WorldPos[" + str(chunk_pos.x) + ", " + str(chunk_pos.y) + "][" + str(tile_pos.x) + ", " + str(tile_pos.y) + "]"
