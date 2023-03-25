extends Node
class_name CardPlayerComponent

signal card_instance_moved(c: CardInstance, from: String, to: String)

@export var deck: Array[CardInstance] = []
@export var hand: Array[CardInstance] = []
var discard: Array[CardInstance] = []

func move_card_instance(c: CardInstance, from: String, to: String) -> void:
	var f: Array[CardInstance] = self[from]
	var t: Array[CardInstance] = self[to]
	f.remove_at(f.find(c))
	t.append(c)
	card_instance_moved.emit(c, from, to)
