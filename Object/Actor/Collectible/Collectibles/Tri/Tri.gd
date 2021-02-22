extends Collectible

export var color_id: int = 0 setget set_color_id
const colors: = [
	Color(1, 0, 0),
	Color(1, 1, 0),
	Color(0, 1, 0),
	Color(0, 0, 1)
]

func get_color() -> Color:
	return colors[color_id]

func set_color_id(val: int):
	color_id = val
	sprite.modulate = get_color()

func _ready():
	pass
