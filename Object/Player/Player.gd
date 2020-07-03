extends KinematicBody2D

export var base_gravity = 1
var gravity = base_gravity

var velocity := Vector2()

func _process(delta):
	
	velocity.y += gravity
	
	move_and_slide(velocity * delta * G.delta_factor, Vector2.UP)

func _input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = -15
