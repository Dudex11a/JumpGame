extends Node
class_name Audio

onready var menu := $Menu

func play_sound(stream: AudioStream):
	if !menu:
		menu = $Menu
	menu.stop()
	menu.stream = stream
	menu.play()
