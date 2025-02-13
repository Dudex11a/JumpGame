extends TabContainer

#onready var anim_player: = get_node("../AnimationPlayer")
onready var title: = $Start/TitleCenter/Title
onready var globals: = get_parent().get_node("Globals")
# If the tabs are transing
export var trans_in_p: = 0.0 setget set_trans_in_p
export var trans_out_p: = 0.0 setget set_trans_out_p
onready var trans_player = $TransitionPlayer
var trans_right: = true

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

func goto_tab(id: int, anim_in: = true):
	trans_right = anim_in
	# If there's a transtion already going on, don't
	if trans_player.is_playing():
		return
	trans_player.play("TransitionIn")
	yield(trans_player, "animation_finished")
	current_tab = id
	# Set title instrument to active if it is in frame
	var is_tab_0 = current_tab == 0
	title.active = is_tab_0
	globals.idle_anim_active = is_tab_0
	trans_player.play("TransitionOut")
	yield(trans_player, "animation_finished")
	# Set trans right back to default
	trans_right = true

## Loop anim
#func play_wobble(anim_name):
#	anim_player.play("TitleWobble")

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

func set_trans_in_p(val):
	trans_in_p = val
	trans(val)
	
func set_trans_out_p(val):
	trans_out_p = val
	trans(val, true)

func trans(val, slide_in: = false, right: = trans_right):
	var screen_x = get_viewport().size.x
#	var rect_pos_x = ((fmod((trans_in_p * 2) + 1, 2)) - 1) * screen_x
	var dir: = 1.0
	if not right: dir *= -1.0
	var slide_mod: = 0.0
	if slide_in: slide_mod = -1.0
	var rect_pos_x = ((val + slide_mod) * dir) * screen_x
	rect_position.x = rect_pos_x
