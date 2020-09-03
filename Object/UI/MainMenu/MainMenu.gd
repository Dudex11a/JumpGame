extends TabContainer

onready var anim_player: = get_node("../AnimationPlayer")

func _ready():
	# Credits text
	$Credits/Container/Label.text = G.load_txt("res://Credits.tres")

func start(difficulty: int = 1):
	G.start_game(difficulty)

func exit():
	S.save_game()
	yield(get_tree().create_timer(.3), "timeout")
	get_tree().quit()

func goto_tab(id: int):
	current_tab = id

# Loop anim
func play_wobble(anim_name):
	anim_player.play("TitleWobble")
