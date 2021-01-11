extends Control

onready var world_grid = $ScrollContainer/CenterContainer/GridContainer

func _ready():
	var world_cards = world_grid.get_children()
	# Connect each card button to ... when it's pressed
	for card in world_cards:
		card.connect("pressed", get_parent(), "goto_tab", [5])
