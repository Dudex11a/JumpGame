extends Control

onready var player_model := $Player
onready var hats_container := $Box1/Hats/Hats
onready var none_hat_button := hats_container.get_node("None")
onready var box_1 := $Box1
onready var color_picker := box_1.get_node("ColorPicker")
onready var box_2 := $Box2
onready var color_button_container := box_2.get_node("Color")
onready var box_3 := $Box3
onready var preview_button := box_3.get_node("Buy/Preview")

onready var globals_anim_player := get_node("../../Globals/AnimationPlayer")

var selected_hat: String
var selected_hat_button: DButton

var selected_color_button: DButton

func _ready():
	# Init hat
	select_hat("None", none_hat_button)
	# Connect None button
	none_hat_button.connect("pressed", self, "select_hat", ["None", none_hat_button])
	# Deactivate the play so he don't fly away :/
	player_model.active = false
	# Create hats buttons
	var hat_paths = G.get_files(P.hat_images)
	for path in hat_paths:
		# Is an import file
		if ".import" in path:
			var button: Button = G.make_node(P.buy_hat_tscn)
			var hat_name: String = G.path_to_name(path)
			hats_container.add_child(button)
			button.icon = load(path)
			button.set_hat_name(hat_name)
			button.cost = 40
			button.connect("pressed", self, "select_hat", [G.path_to_name(path), button])
			if button is BuyHat:
				button.update_cost()

func reset_menu():
	if selected_color_button:
		selected_color_button.pressed = false
	if selected_hat_button:
		selected_hat_button.pressed = false
	set_player_color(0)

func select_hat(hat_name: String, button: DButton):
	# Wait for the hat to be bought if it's a buy hat button
	if button is BuyHat:
		yield(get_tree().create_timer(0.01), "timeout")
	# Set player model's hat back to the save
	# This is so previewing a hat will stop when another hat is selected
	player_model.change_hat(S.hat)
	# set selected hat
	selected_hat = hat_name
	# Disable the button that was just pressed
	if selected_hat_button:
		selected_hat_button.disabled = false
	selected_hat_button = button
	selected_hat_button.disabled = true
	update_box_3()

func update_box_3():
	if S.obtained_hats.has(selected_hat) or selected_hat == "None":
		# Goto Equip
		box_3.current_tab = 1
	else:
		# Goto Buy
		box_3.current_tab = 0
		preview_button.pressed = false

func buy_hat():
	if S.currency >= selected_hat_button.cost:
		S.add_hat(selected_hat)
		S.currency -= selected_hat_button.cost
		# Remove cost
		selected_hat_button.set_cost(0)
		update_box_3()
	else:
		globals_anim_player.play("CurrencyError")
		G.A.play_sound(load(P.error_sound), 1)

func equip_hat():
	S.hat = selected_hat
	player_model.change_hat(selected_hat)

func preview_hat():
	if preview_button.pressed:
		player_model.change_hat(selected_hat)
	else:
		player_model.change_hat(S.hat)

func set_player_color(child_index: int):
	# Disable other button
	var index := 0
	var button: DButton
	for child in color_button_container.get_children():
		# If the child is the button pressed
		if index == child_index:
			button = child
		else:
			# Untoggle button
			child.pressed = false
		# Increment index
		index += 1
	selected_color_button = button
	# Set color picker values
	var values: Array
	match selected_color_button.get_index():
		0:
			values = S.hat_color
		1:
			values = S.dog_color
	color_picker.set_values(values)
	# If the button is toggled on, display the color picker
	if button.pressed:
		box_1.current_tab = 1
	else:
		box_1.current_tab = 0

func color_picker_changed(hsv: Array):
	match selected_color_button.get_index():
		0:
			S.hat_color = hsv
		1:
			S.dog_color = hsv
	player_model.change_hsv()


func mainmenu_tab_changed(tab):
	if tab == 2:
		reset_menu()

func _on_DogButton():
	player_model.bark()
	player_model.misc_anim.wiggle()
