extends Node
class_name GameLogicTimer

const TICKS_PER_SECOND: int = 20
const TICK_TIME: float = 1.0 / TICKS_PER_SECOND

var game_logic_thread: = Thread.new()
var current_time: int = OS.get_unix_time()
var isDone: = false

var accumulation: float = 0

onready var game_logic = get_child(0)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var new_time: int = OS.get_unix_time()
	var frame_time: int = new_time - current_time;

	# The following if check is to make sure we don't fall into the spiral of death
	# TODO: Figure out if this is easy to hack
	if frame_time >= 1000:
		frame_time = 1000

	current_time = new_time
	accumulation += frame_time

	# Updating as many times as needed to make up for any lag
	while accumulation >= 1.0 / TICKS_PER_SECOND:
		update()
		accumulation = max(accumulation - 1.0 / TICKS_PER_SECOND, 0)

func update() -> void:
	game_logic.update()

