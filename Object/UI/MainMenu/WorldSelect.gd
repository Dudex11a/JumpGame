extends Control

onready var world_grid = $ScrollContainer/CenterContainer/GridContainer
onready var world_preview = get_parent().get_node("WorldPreview")
onready var main_menu = get_parent()

func _ready():
	var world_cards = world_grid.get_children()
	# Connect each card button to ... when it's pressed
	for card in world_cards:
		card.connect("enter", self, "open_preview", [card])
#		if S.worlds.has(card.world_name):
#			if S.worlds[card.world_name].owned == true:
#				card.owned = true

func open_preview(card: WorldCard):
	# Set up world preview tab with card data
	world_preview.load_data(card)
	# Goto WorldPreview tab
	main_menu.goto_tab(5)
