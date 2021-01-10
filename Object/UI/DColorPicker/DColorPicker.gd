extends Control

onready var background := $Background
onready var container = $Container/PickerContainer
onready var sliders = [
	container.get_node("Hue/Slider"),
	container.get_node("Saturation/Slider"),
	container.get_node("Value/Slider")
]
onready var title = $Container/Title

signal changed
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

func changed(value = null):
	emit_signal("values_changed", make_values())
#	background.self_modulate = (make_color() * 0.8).lightened(0.1)
