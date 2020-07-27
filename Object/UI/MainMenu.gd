extends TabContainer

onready var anim_player: = get_node("../AnimationPlayer")

func start(difficulty: int = 1):
	G.start_game(difficulty)

func exit():
	get_tree().quit()
	
func goto_difficulty():
	current_tab = 1

func goto_start():
	current_tab = 0

# Loop anim
func play_wobble(anim_name):
	anim_player.play("TitleWobble")
