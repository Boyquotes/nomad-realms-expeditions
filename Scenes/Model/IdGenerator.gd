extends Node

var id: int = -1

func generate_id() -> int:
	id += 1
	return id
