extends Enemy

export var v_speed: float = 1

func _physics_process(delta):
	velocity.y = v_speed * G.movement_mod
	velocity.x = -speed
	
	# Tilt
	sprite.rotation = velocity.y

func collision(collision: KinematicCollision2D):
	# Bounce
	v_speed *= -1
