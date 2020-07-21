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
	var viewport := get_viewport()
	
	# Delete all children that aren't node
	for child in viewport.get_children():
		if child.get_class() != "Node":
			child.queue_free()
			
	# Start loading the node
	var scene = make_node(scene_path)
	# Start anim
	var transition = make_node("res://Object/SceneTransition/SceneTransition.tscn")
	viewport.add_child(transition)
	yield(transition, "finished_in")
	
	# Add scene given
	viewport.add_child(scene)
	
	# End anim

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

func make_time(msecs_elapsed: int) -> String:
	var secs_elapsed := int(msecs_elapsed / 1000)
	var seconds := secs_elapsed % 60
	
	var minutes_elapsed: int = floor(float(secs_elapsed) / 60.0)
	var minutes := minutes_elapsed % 60
	
	var hours := floor(float(minutes_elapsed) / 60.0)
	
	var seconds_string := String(seconds)
	if seconds_string.length() < 2:
		seconds_string = "0" + seconds_string
		
	var minutes_string := String(minutes)
	if minutes_string.length() < 2:
		minutes_string = "0" + minutes_string
	minutes_string += ":"
		
	var hours_string := ""
	if hours > 0:
		hours_string = String(hours) + ":"
	
	var time_string := hours_string + minutes_string + seconds_string
	return time_string

func get_main() -> Node:
	for node in get_viewport().get_children():
		if node.name == "Main":
			return node
	return null

func is_game_over() -> bool:
	if get_main():
		return get_main().is_game_over
	return true
