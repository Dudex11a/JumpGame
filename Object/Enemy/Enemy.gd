extends KinematicBody2D
func get_class(): return "Enemy"

export var speed := -5.0
var speed_mod := 1.0

func _physics_process(delta):
	var collision := move_and_collide(Vector2(-5 * delta * G.delta_factor, 0))
	if collision:
		if collision.collider.get_class() == "Player":
			get_tree().call_group("PlayerCollision", "player_collision", self)

func player_collision(collider):
	queue_free()

func change_speed_mod(speed_mod: float):
	self.speed_mod = speed_mod
