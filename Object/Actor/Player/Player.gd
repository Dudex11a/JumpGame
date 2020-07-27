extends Actor
func get_class(): return "Player"

onready var death_anim := $DeathAnimPlayer
onready var se := $SE
onready var se_thruster := $SEThruster

var score := 0 setget set_score

signal jump

var rest_time := 0.3
var last_collision: float

func _ready():
	# This two lines are so you start out with no gravity
	# but when you jump gravity kicks on
	connect("jump", self, "first_jump")
	gravity = 0

func _process(delta):
	# If is not in death anim
	if not (death_anim.is_playing() and death_anim.current_animation == "Death"):
		tilt_by_velocity()

func tilt_by_velocity():
	var tilt := clamp(velocity.y, -500, 500) / 1000
	if is_on_floor():
		tilt = 0
	sprite.rotation = tilt

# Set the gravity and disconnect the signal so it won't be called again
func first_jump():
	gravity = base_gravity
	disconnect("jump", self, "first_jump")

func _input(event):
	if event.is_action_pressed("jump"):
		rising = true
		emit_signal("jump")
		# Play Sound
		se.pitch_scale = G.rng.randf_range(0.8, 1.2)
		se.play()
		play_thruster()
		
	if event.is_action_released("jump"):
		rising = false
	if event.is_action_released("return"):
		G.change_to_main_menu()

const loop_start := .037
const loop_end := .147
func play_thruster():
	if not se_thruster.playing:
		se_thruster.play()
	if rising and active:
		se_thruster.play(loop_start)
		yield(get_tree().create_timer(loop_end - loop_start), "timeout")
		play_thruster()

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
	if not (death_anim.current_animation_position - rest_time < last_collision):
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
	get_tree().call_group("PlayerDeath", "player_death")
	yield(death_anim, "animation_finished")
	get_tree().call_group("GameOver", "game_over")

func detected(body):
	if body is Enemy:
		death()
		get_tree().call_group("PlayerCollision", "player_collision", body)
