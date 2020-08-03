extends Actor
class_name Enemy
func get_class(): return "Enemy"

var speed_mod := 1.0

func player_death():
	self.active = false
	sprite.modulate.v = 0
