extends Node2D

onready var player := $Player
onready var score_label := $UI/PanelContainer/Score
onready var results := $UI/Results

func lose():
	G.change_to_main_menu()

func score(score: int):
	score_label.text = String(score)

func player_collision(collider):
	results.visible = true

func _PlayerLine_body_exited(body):
	if body.get_class() == "Enemy":
		player.score += 1

func _on_DestroyLine_body_exited(body):
	if body.get_class() == "Enemy":
		body.queue_free()

func restart():
	G.start_game()

func goto_mainmenu():
	G.change_to_main_menu()
