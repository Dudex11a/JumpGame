extends Node2D

var restart_res

func _on_Restart_pressed():
	if restart_res:
		G.change_scene(restart_res.instance())

func _on_MainMenu_pressed():
	G.change_to_main_menu()
