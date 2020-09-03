extends "res://Object/Actor/Enemy/Enemies/BasicEnemy/BasicEnemy.gd"
class_name EndPoint
func get_class(): return "EndPoint"

func _ready():
	# Turn invisible if not debug
	if not OS.is_debug_build():
		visible = false
