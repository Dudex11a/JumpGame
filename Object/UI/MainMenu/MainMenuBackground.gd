extends Node2D

onready var clouds := get_children()

func _process(delta):
	G.advance_clouds(clouds, 1)
