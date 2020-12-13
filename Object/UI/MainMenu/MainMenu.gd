extends TabContainer

onready var anim_player: = get_node("../AnimationPlayer")

func _ready():
	interp_os()
	# Credits text
	make_credits()
#	$Credits/Container/Label.text = G.load_txt("res://Credits.tres")

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

func interp_os():
	match OS.get_name():
		"Android", "IOS":
			var exit_button = $"Start/Exit"
			exit_button.queue_free()

func make_credits():
	var links_cont = $"Credits/VBoxContainer/ScrollContainer/LinksContainer"
	var txt = G.load_txt("res://Credits.json")
	var credits_vals = JSON.parse(txt).result
	# For each category
	for cat_name in credits_vals:
		var cat = credits_vals[cat_name]
		# Create label for category
		var cat_label := Label.new()
		cat_label.align = Label.ALIGN_CENTER
		cat_label.text = cat_name
		links_cont.add_child(cat_label)
		# For each link in a category (i.e. Dog in Sounds)
		for link_name in cat:
			var link = cat[link_name]
			# Create DButton for link
			var link_button = load(P.link_button).instance()
			link_button.text = link_name
			link_button.link = link
			links_cont.add_child(link_button)
