extends Actor
func get_class(): return "Player"

onready var death_anim := $DeathAnimPlayer

var score := 0 setget set_score

var last_collision: float

func _input(event):
	if event.is_action_pressed("jump"):
		rising = true
		# Fast burst of speed
#		velocity.y -= 500
	if event.is_action_released("jump"):
		rising = false
	if event.is_action_released("return"):
		G.change_to_main_menu()

func set_score(new_score: int):
	score = new_score
	get_tree().call_group("Score", "score", score)

func collision(collision: KinematicCollision2D):
	var c = collision.collider
	if c is Collision:
		start_death_countdown()
		last_collision = death_anim.current_animation_position

func start_death_countdown():
	if !death_anim.is_playing() and active:
		death_anim.play("CollisionCountdown")

func update_countdown():
	# If it's been too long since the last collision stop
	if not (death_anim.current_animation_position - 0.5 < last_collision):
		death_anim.stop(true)

# Check if the player is on the floor or cieling moments before the kill
# This gives a sort of last chance situation
func last_check():
	if not(is_on_floor() or is_on_ceiling()):
		death_anim.stop(true)

func death():
	self.active = false
	death_anim.stop(true)
	death_anim.play("Death")
	yield(death_anim, "animation_finished")
	get_tree().call_group("GameOver", "game_over")

func detected(body):
	if body is Enemy:
		death()
		get_tree().call_group("PlayerCollision", "player_collision", body)
