extends Node

const save_location := "user://save_game.dat"

func _init():
	load_game()

var _file := File.new()

var high_score := 0 setget set_high_score
var currency := 0 setget set_currency
var hat := ""
var hat_color: Array = [1, .5, 1]
var dog_color: Array = [1, .5, 1]
var obtained_hats := []

signal set_property

signal game_saved

func _ready():
	# Connect when certen properties are changed call group function set_property
	connect("set_property", get_tree(), "call_group", ["Globals", "set_property"])

func set_high_score(value: int):
	high_score = value
	emit_signal("set_property")
	
func set_currency(value: int):
	# Play purchase sound, the "if P" is here because P can be null on startup
	if P and currency < value:
		G.A.play_sound(load(P.currency_sound), 1)
	currency = value
	emit_signal("set_property")

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

func add_hat(hat: String) -> bool:
	if not obtained_hats.has(hat):
		obtained_hats.append(hat)
		return true
	return false

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
		if data.has(name):
			# If type mismatch
#			if typeof(self[name]) != typeof(data[name]):
#				print(name)
			# Handle colors
			if self[name] is Color:
				var d = data[name]
				# Turn color string to float
				self[name] = Color(
					float(d[0]),
					float(d[2]),
					float(d[4]),
					float(d[6])
					)
			else:
				# Handle all other data
				self[name] = data[name]
	_file.close()
