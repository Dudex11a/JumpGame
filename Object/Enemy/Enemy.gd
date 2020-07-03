extends KinematicBody2D

func _process(delta):
	move_and_slide(Vector2(-5 * delta * G.delta_factor, 0), Vector2.UP)
