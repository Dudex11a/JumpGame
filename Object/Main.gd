extends Node2D

onready var player := $Player
onready var score_label := $Camera/UI/PanelContainer/Score
onready var results := $Camera/UI/Results
onready var clouds: Array = [
	$Clouds1,
	$Clouds2
]

var max_speed_up := G.max_speed_up
var how_many_to_max := G.how_many_to_max

func _ready():
	$Camera/UI.rect_size = get_viewport_rect().size

func _process(delta):
	advance_clouds()

func lose():
	G.change_to_main_menu()

func score(score: int):
	score_label.text = String(score)

func game_over():
	results.visible = true

# Score points
func _PlayerLine_body_exited(body):
	if body.get_class() == "EndPoint":
		player.score += 1
#		if Engine.time_scale != max_speed_up:
#			var difference := max_speed_up - 1.0
#			var increment := difference / how_many_to_max
#			Engine.time_scale += increment
#		if Engine.time_scale > max_speed_up:
#			Engine.time_scale = max_speed_up

func _on_DestroyLine_body_exited(body):
	if body is Enemy:
		body.queue_free()

func restart():
	G.start_game()

func goto_mainmenu():
	G.change_to_main_menu()

func advance_clouds():
	for cloud in clouds:
		cloud.region_rect.position.x += 1
