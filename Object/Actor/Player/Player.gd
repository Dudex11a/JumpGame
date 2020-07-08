extends Actor
func get_class(): return "Player"

var score := 0 setget set_score


func _input(event):
	if event.is_action_pressed("jump"):
		rising = true
		# Fast burst of speed
		velocity.y -= 1000
	if event.is_action_released("jump"):
		rising = false
	if event.is_action_released("return"):
		G.change_to_main_menu()

func set_score(new_score: int):
	score = new_score
	get_tree().call_group("Score", "score", score)

func collision(collision: KinematicCollision2D):
	pass

func detected(body):
	if body is Enemy:
		get_tree().call_group("PlayerCollision", "player_collision", body)
