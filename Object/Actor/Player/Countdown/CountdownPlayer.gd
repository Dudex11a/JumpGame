extends AnimationPlayer

onready var sprite := get_node("../CountdownSprite")

func countdown(number: int):
	# Reset Anim so it can interupt itself
	stop(true)
	sprite.visible = true
	# Set the number displayed
	sprite.frame = number
	# Start the anim
	play("Countdown")
	# Wait until the animation is complete to return to invisable
	yield(self, "animation_finished")
	sprite.visible = false
