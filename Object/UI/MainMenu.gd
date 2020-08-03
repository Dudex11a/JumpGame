extends TabContainer

onready var anim_player: = get_node("../AnimationPlayer")
onready var hats_container := $Hats/Hats/Hats
onready var player_model := $Hats/Player

func _ready():
	# Credits text
	$Credits/Text.text = G.load_txt("res://Credits.tres")
	# Deactivate the play so he don't fly away :/
	$Hats/Player.active = false
	# Create hats buttons
	var hat_paths = G.get_files(P.hat_images)
	hat_paths.append("None.import")
	for path in hat_paths:
		# Is an import file
		if ".import" in path:
			var button: Button = G.make_node(P.button)
			var hat_name = G.path_to_name(path)
			button.icon = load(path)
			button.text = hat_name
			hats_container.add_child(button)
			button.connect("pressed", self, "set_hat", [G.path_to_name(path)])


func set_hat(hat_name: String):
	S.hat = hat_name
	player_model.change_hat(hat_name)

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
