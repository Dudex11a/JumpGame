extends KinematicBody2D
class_name Actor
func get_class(): return "Actor"

export var speed: float = 1
export var base_gravity: float = 1
onready var gravity := base_gravity
var velocity := Vector2()
var rising := false
var active := true setget set_active

func _physics_process(delta):
	
	var final_gravity: float = gravity * 100
	
	if rising:
		velocity.y -= final_gravity * 3
	
	velocity.x *= 200
	velocity.y += final_gravity
	
	velocity *= delta * G.delta_factor
	
	move_and_slide(velocity, Vector2.UP)
	
	for index in range(0, get_slide_count()):
		collision(get_slide_collision(index))

func collision(collision: KinematicCollision2D):
	pass

func set_active(value: bool):
	active = value
	set_physics_process(value)
