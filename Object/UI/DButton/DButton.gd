extends Button
class_name DButton

export var press_down_sound: AudioStream
export var press_up_sound: AudioStream
onready var label: = $Label

func _ready():
	replace_button_text()
	# Have to do this manually here for some reason
	connect("button_down", self, "_on_Button_button_down")
	connect("button_up", self, "_on_Button_button_up")

func _on_Button_button_down():
	G.A.play_sound(press_down_sound)

func _on_Button_button_up():
	G.A.play_sound(press_up_sound)
	
func set_text(val):
	replace_button_text(val)

func replace_button_text(val: = text):
	label.text = val
	text = ""
