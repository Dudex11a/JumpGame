extends Actor
class_name Collectible
func get_class(): return "Collectible"

func _physics_process(delta):
	velocity.x = -speed

func player_death():
	self.active = false
	sprite.modulate.v = 0

func _on_CollectArea_body_entered(body):
	if body.get_class() == "Player":
		collected()

func collected():
	# What the collectible should do,
	# this will be defined in other instances of this node
	queue_free()
