extends AnimationPlayer

onready var dog := get_parent()

# Gotta wiggle for the juice
export var wiggle_time := 1.0 setget wiggle_anim
var wiggle_max: float = 0.8
var wiggle_min: float = 0.2
var wiggle_start_rot: float

# Play wiggle animation, you can't play it regularly
# from the animation player because it won't have any randomness to it
func wiggle():
	# Get a positive or negative at random
	var pos = 1
	if G.rng.randi_range(0, 1) == 0:
		pos *= -1
	wiggle_start_rot = G.rng.randf_range(wiggle_min, wiggle_max) * pos
	stop()
	play("Wiggle")

# This is ran each time the wiggle time is set
func wiggle_anim(time):
	if (dog):
		# The point in which the animation is
		var amount = lerp(0, wiggle_start_rot, time)
		# Set rotation to the basic amount
		dog.sprite.rotation = amount
		# I have to add 1 to the amount otherwise it'll end the scale
		# on 0 which will make the dog invisible.
		var scale = abs(amount) + 1
		for axis in range(2):
			dog.sprite.scale[axis] = scale
