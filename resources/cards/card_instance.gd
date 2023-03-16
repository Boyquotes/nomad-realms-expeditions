extends Resource
class_name CardInstance

@export var card: Card

# Create card instances using `CardInstance.new(c)`
func _init(c: Card):
	card = c
