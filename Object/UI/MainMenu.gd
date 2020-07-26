extends TabContainer

func start(difficulty: int = 1):
	G.start_game(difficulty)

func exit():
	get_tree().quit()
	
func goto_difficulty():
	current_tab = 1

func goto_start():
	current_tab = 0
