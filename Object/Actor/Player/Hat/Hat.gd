extends AnimatedSprite
class_name Hat

func make_basic(hat_name):
	name = hat_name
	var path := P.hat_images + "/" + name + ".png"
	var image = load(path)
	# Add image
	frames.add_frame("default", image)
