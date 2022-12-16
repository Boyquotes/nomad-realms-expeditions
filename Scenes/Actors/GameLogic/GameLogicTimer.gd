extends Object
class_name GameLogicTimer

const TICKS_PER_SECOND: int = 20
const TICK_TIME: float = 1.0 / TICKS_PER_SECOND

var game_logic_thread: = Thread.new()
var current_time: int = Time.get_unix_time_from_system()
var isDone: = false

var accumulation: float = 0

var game_logic

func _init(game_logic):
	self.game_logic = game_logic

func update(delta: float) -> void:
	var new_time: int = Time.get_unix_time_from_system()
	var frame_time: int = new_time - current_time;

	# The following if check is to make sure we don't fall into the spiral of death
	# TODO: Figure out if this is easy to hack
	if frame_time >= 1000:
		frame_time = 1000

	current_time = new_time
	accumulation += frame_time

	# Updating as many times as needed to make up for any lag
	while accumulation >= 1.0 / TICKS_PER_SECOND:
		game_logic.update()
		accumulation = max(accumulation - 1.0 / TICKS_PER_SECOND, 0)

