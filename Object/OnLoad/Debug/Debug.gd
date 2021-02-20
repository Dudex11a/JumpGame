extends Node
class_name Debug

func _ready():
	print(name, " is loaded.")

func _input(event):
	if event.is_action_pressed("debug_1"):
		S.currency += 1
	if event.is_action_pressed("debug_2"):
		get_tree().call_group("Debug", "debug_2")
