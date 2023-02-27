extends Actor

@export var highlight_flash: ShaderMaterial

func _ready():
	rotate_y(randf_range(0, TAU))

func update():
	if !card_player_component.hand.is_empty():
		if card_player_component.hand[0].card == GameCards.REGENESIS:
			# TODO: Play card
			print("Wolf ", self, " played REGENESIS!!")

func set_highlighted(h: bool) -> void:
	super.set_highlighted(h)
	if h:
		mesh.material_overlay = highlight_flash
	else:
		mesh.material_overlay = null
