extends Resource
class_name WorldPos

@export var tile_pos: Vector2i

func _init(tx, ty):
	tile_pos = Vector2i(tx, ty)

func shifted() -> bool:
	return tile_pos.x % 2 == 1

func distance_to(other: WorldPos) -> int:
	var diff: = other.tile_pos - tile_pos
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
	return tile_pos == other.tile_pos

func plus(x: int, y: int) -> WorldPos:
	return WorldPos.new(tile_pos.x + x, tile_pos.y + y)

func _to_string():
	return "WorldPos[" + str(tile_pos.x) + ", " + str(tile_pos.y) + "]"
