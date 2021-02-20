extends Control

onready var background_node: = $Background
onready var highscore_a_node: = $HighScoreAmount
onready var tris_node: = $Tris
onready var name_node: = $Name

var world_to_play: PackedScene

# Load the data from card into the respective nodes
func load_data(card: WorldCard):
	background_node.texture = card.full_image
	var world_name: = card.world_name
	name_node.text = world_name
	var hs = S.get_world_val(world_name, "highscore")
	if hs is int or hs is float:
		highscore_a_node.text = String(hs)
	if card.world:
		world_to_play = card.world

func _on_Play_pressed():
	if world_to_play:
		G.change_scene(world_to_play.instance())
	else:
		print("This card has no DWorld connected to it.")
