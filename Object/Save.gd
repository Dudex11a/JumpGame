extends Node

const save_location := "user://save_game.dat"

func _init():
	load_game()

var _file := File.new()

var high_score := 0
var currency := 0

func get_property_names() -> Array:
	var properties := []
	# This gets all the properties from this object
	# and puts the ones I want in a Dictionary.
	for property in get_property_list():
		# I'm unsure what usage 8912 is right now but
		# it's consistant with the properties I want.
		if property.usage == 8192 and property.name[0] != "_":
			properties.append(property.name)
	return properties

func _to_string() -> String:
	var data := {}
	for name in get_property_names():
		data[name] = self[name]
	return String(data)

func save_game():
	_file.open(save_location, _file.WRITE)\
	#
	var data := {}
	for name in get_property_names():
		data[name] = self[name]
	_file.store_string(JSON.print(data))
	_file.close()

func collect_content():
	G.get_tree().call_group("CollectContent", "send_content")
	
func collect_save():
	collect_content()
	save_game()

func load_game():
	# If the save doesn't exist create one
	if not _file.file_exists(save_location):
		save_game()
		return
	_file.open(save_location, _file.READ)
	var json_content := JSON.parse(_file.get_as_text())
	var data: Dictionary = json_content.result
	# Write the data to content
	# The reason why I write the properties individually is so
	# that if I add new data to the save it will have that
	# new data.
	for name in get_property_names():
		self[name] = data[name]
	_file.close()
