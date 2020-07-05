extends Node

const delta_factor := 50
var rng := RandomNumberGenerator.new()

func change_scene(scene_path: String):
	# Delete all children that aren't node
	for child in get_viewport().get_children():
		if child.get_class() != "Node":
			child.queue_free()
	# Add scene given
	var scene_resource := load(scene_path)
	var scene = scene_resource.instance()
	get_viewport().add_child(scene)

func start_game():
	change_scene("res://Object/Main.tscn")

func change_to_main_menu():
	change_scene("res://Object/UI/MainMenu.tscn")
