extends Actor
class_name Enemy
func get_class(): return "Enemy"

var speed_mod := 1.0

func _physics_process(delta):
	velocity.x = speed

func player_collision(collider):
	queue_free()

func change_speed_mod(speed_mod: float):
	self.speed_mod = speed_mod
