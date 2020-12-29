extends Actor
func get_class(): return "Player"

onready var death_anim := $DeathAnimPlayer
onready var misc_anim := $MiscAnimPlayer
onready var se := $SE
onready var se_thruster := $SEThruster
onready var thruster := $Thruster
onready var hat_spot := sprite.get_node("HatSpot")


onready var dog_anims := sprite.get_node("DogAnims")
onready var dog_sprite := sprite.get_node("Dog")
onready var eye := dog_sprite.get_node("Eye")
onready var mouth := dog_sprite.get_node("Mouth")
onready var front_legs := dog_sprite.get_node("FrontLegs")
onready var tail := dog_sprite.get_node("Tail")

var score := 0 setget set_score

signal jump

var rest_time := 0.3
var last_collision: float

func _ready():
	# This two lines are so you start out with no gravity
	# but when you jump gravity kicks on
	connect("jump", self, "first_jump")
	gravity = 0
	change_hat(S.hat)
	change_hsv()

func _physics_process(delta):
	# If is not in death anim
	if not (death_anim.is_playing() and death_anim.current_animation == "Death"):
		tilt_by_velocity()

func _input(event):
	if event.is_action_pressed("jump"):
		rising = true
		emit_signal("jump")
		# Play Sound
		bark()
		se_thruster.play()
		thruster.emitting = true
		dog_anims.play("Rising")
		
	if event.is_action_released("jump"):
		rising = false
		se_thruster.stop()
		thruster.emitting = false
		dog_anims.play_backwards("Rising")
		
	if event.is_action_released("return"):
		G.change_to_main_menu()
		
func tilt_by_velocity():
	var tilt := clamp(velocity.y, -500, 500) / 1000
	if is_on_floor():
		tilt = 0
	sprite.rotation = tilt
	
# Set the gravity and disconnect the signal so it won't be called again
func first_jump():
	gravity = base_gravity
	disconnect("jump", self, "first_jump")

func play_anim_sprite(sprite: AnimatedSprite):
	sprite.frame = 0
	sprite.play("default")

func blink():
	play_anim_sprite(eye)

func bark():
	se.pitch_scale = G.rng.randf_range(0.8, 1.2)
	se.play()
	play_anim_sprite(mouth)

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
	thruster.emitting = false
	G.A.play_sound(load("res://Sound/Chaos.wav"), 1)
	se_thruster.stop()
	death_anim.stop(true)
	death_anim.play("Death")
	get_tree().call_group("PlayerDeath", "player_death")
	yield(death_anim, "animation_finished")
	get_tree().call_group("GameOver", "game_over")

func detected(body):
	if body is Enemy:
		death()

func change_hat(hat_name := ""):
	# Remove old hat
	for child in hat_spot.get_children():
		child.free()
	
	# Take off hat if empty
	if hat_name == "":
		return
		
	hat_spot.add_child(make_basic_hat(hat_name))

func make_basic_hat(hat_name: String) -> AnimatedSprite:
	var hat = G.make_node(P.hat_obj)
	hat.make_basic(hat_name)
	return hat

func change_hsv(dog: Array = S.dog_color, hat: Array = S.hat_color):
	dog_sprite.material.set("shader_param/hsv", Vector3(dog[0], dog[1], dog[2]))
	hat_spot.material.set("shader_param/hsv", Vector3(hat[0], hat[1], hat[2]))
