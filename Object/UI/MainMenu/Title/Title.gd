extends Control

onready var anim_player = $AnimationPlayer

export var wiggle_mod = 1.0 setget set_wiggle_mod

# The reason why I have to have a mouse pressed is because
var mouse_pressed: bool = false

var active: = true

var notes_pressed: String
var note_limit: = 10
var codes: Dictionary = {
	"test1": "LOGOFF",
	"Test2": "GODLY",
	"test3": "GOOD",
	"123": "DOGFLY!?"
}

func set_shader_param(param: String, value):
	# Set shader_param value to each sprite
	for child in get_children():
		if child is Sprite:
			child.material.set("shader_param/" + param, value)

func set_wiggle_mod(val):
	set_shader_param("wiggle_mod", val)
	wiggle_mod = val

func log_note(val):
	notes_pressed += val
	# Remove notes in front if too many
	if notes_pressed.length() >= note_limit:
		notes_pressed = notes_pressed.right(notes_pressed.length() - note_limit)
	var matched_code = check_for_codes()
	if matched_code:
		print(matched_code)

func check_for_codes(notes = notes_pressed):
	for index in codes:
		var code = codes[index]
#		If the code is in the notes that have been pressed
		if notes.find(code) >= 0:
			notes_pressed = ""
			return index
