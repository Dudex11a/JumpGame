extends Actor
class_name Enemy
func get_class(): return "Enemy"

var speed_mod := 1.0

func player_collision(collider):
	game_over()

func game_over():
	queue_free()

func change_speed_mod(speed_mod: float):
	self.speed_mod = speed_mod
