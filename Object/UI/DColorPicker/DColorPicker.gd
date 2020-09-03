extends Control

onready var background_panel := $Background
onready var container = $Container
onready var sliders = [
	container.get_node("Hue/Slider"),
	container.get_node("Saturation/Slider"),
	container.get_node("Value/Slider")
]

signal changed
signal color_changed
signal values_changed

func make_color() -> Color:
	var values := make_values()
	return Color.from_hsv(
		values[0],
		values[1],
		values[2]
		)

func set_values(array: Array):
	var index := 0
	for slider in sliders:
		slider.value = array[index] * 100.0
		index += 1

func make_values() -> Array:
	return [
		sliders[0].value / 100.0,
		sliders[1].value / 100.0,
		sliders[2].value / 100.0
		]

func changed(value):
#	emit_signal("color_changed", make_color())
	emit_signal("values_changed", make_values())

func color_changed(color: Color):
	pass
#	set_background_color(color)
#
#func set_background_color(color: Color = make_color()):
#	background_panel.modulate = color
