extends Node

const delta_factor := 50.0
const max_speed_up := 2.0
const how_many_to_max := 5

const difficulty = {
	easy = -1,
	normal = 0,
	hard = 1
}

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


func get_folders(path: String):
	var dir = Directory.new()
	var folders := []
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			#Filename doesn't being with . and is a folder
			if dir.current_is_dir() and file_name[0] != ".":
				folders.append(path + "/" + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return folders

func get_files(path: String):
	var dir = Directory.new()
	var files := []
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				files.append(path + "/" + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return files

func make_node(path: String) -> Node:
	var resource = load(path)
	return resource.instance()

func random_in_array(array: Array):
	return array[G.rng.randi_range(1, array.size()) - 1]
