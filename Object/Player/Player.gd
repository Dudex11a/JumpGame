extends KinematicBody2D
func get_class(): return "Player"

export var base_gravity = 1
var gravity = base_gravity
var velocity := Vector2()

var score := 0 setget set_score

func _physics_process(delta):
	
	velocity.y += gravity * 50
	
	move_and_slide(velocity * delta * G.delta_factor, Vector2.UP)

func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = -1500
	if event.is_action_released("jump") and velocity.y < 0:
		velocity.y /= 10
	if event.is_action_released("return"):
		G.change_to_main_menu()

func set_score(new_score: int):
	score = new_score
	get_tree().call_group("Score", "score", score)
