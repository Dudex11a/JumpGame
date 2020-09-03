extends Node2D

onready var player := $Player
onready var ui
onready var hud := $HUDLayer/HUD
onready var results_layer := $ResultsLayer
onready var enemy_spawn := $EnemySpawn

onready var start_time := OS.get_ticks_msec()

var difficulty := 1

var is_game_over := false

func _ready():
	hud.rect_size = get_viewport_rect().size
	hud.start_time = start_time

func lose():
	G.change_to_main_menu()

func game_over():
	# Show results
	results_layer.visible = true
	# Display HUD over UI
	$HUDLayer.z_index = 2
	S.currency += player.score
	if S.high_score < player.score:
		S.high_score = player.score
	S.save_game()

# Score points
func _PlayerLine_body_exited(body):
	if body.get_class() == "EndPoint":
		# Add points from sequence to score
		player.score += body.get_parent().points

func _on_DestroyLine_body_exited(body):
	if body is Enemy:
		body.queue_free()

func restart():
	G.start_game(difficulty)

func goto_mainmenu():
	G.change_to_main_menu()
