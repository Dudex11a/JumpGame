extends Control

onready var background := $Background

func _ready():
	rect_size.x = get_viewport().size.x
