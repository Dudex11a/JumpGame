extends Node

const delta_factor := 50.0
const max_speed_up := 2.0
const how_many_to_max := 5
const movement_mod := 200

const difficulty_name = [
	"None",
	"Easy",
	"Normal",
	"Hard"
]

var rng := RandomNumberGenerator.new()

var A: Audio
var D: Debug

func _ready():
	var audio = G.make_node(P.audio_tscn)
	A = audio
	get_node("/root/G").add_child(A)
	# Load debug scene
	if OS.is_debug_build():
		var debug = G.make_node(P.debug_tscn)
		D = debug
		get_node("/root/G").add_child(debug)

func change_scene(scene):
	var viewport := get_viewport()
	
	# Delete all children that have a longer name than 1 char
	for child in viewport.get_children():
#		if child.get_class() != "Node":
		if child.name.length() > 1:
			child.queue_free()
			
	# If the parameter given is a path, make the node
	if scene is String:
		scene = make_node(scene)
	# Start anim
	var transition = make_node("res://Object/SceneTransition/SceneTransition.tscn")
	viewport.add_child(transition)
	
	# Wait until transition is finished
	yield(transition, "finished_in")
	
	# Add scene given
	viewport.add_child(scene)

func start_game(difficulty: int = 1):
	rng.randomize()
	var game = make_node(P.main_tscn)
	# Set the difficulty
	game.difficulty = difficulty
	change_scene(game)

func change_to_main_menu():
	change_scene(P.mainmenu_tscn)


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

func load_txt(file):
	var text: String
	var f = File.new()
	f.open(file, File.READ)
	var index = 0
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		line += "\n"
		text += line
		
		index += 1
	f.close()
	return text

func make_node(path: String) -> Node:
	var resource = load(path)
	return resource.instance()

func path_to_name(path: String) -> String:
	var rgx := RegEx.new()
	rgx.compile("res://(\\S|\\s)*/|\\.(\\S|\\s)*")
	return rgx.sub(path, "", true)

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

# If point is within the box of 2 Vector2s
func within_box(point: Vector2, pos: Vector2, size: Vector2) -> bool:
	var val = true
	for axis in ["x", "y"]:
		var within : bool = (point[axis] >= pos[axis]) && (point[axis] <= pos[axis] + size[axis])
		if not within: val = false
	return val
