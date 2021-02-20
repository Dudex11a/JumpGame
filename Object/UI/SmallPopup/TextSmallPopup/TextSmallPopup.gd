extends "res://Object/UI/SmallPopup/SmallPopup.gd"

onready var label: = $PanelContainer/VBoxContainer/Label
export var text: = "Default" setget set_text

func _ready():
	set_text()

func set_text(val: String = text):
	text = val
	label.text = text
