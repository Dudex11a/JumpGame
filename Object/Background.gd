extends CanvasLayer

onready var background_color := $Color
onready var background_anim := $BackgroundAnimation

func _ready():
	# Connect background anim so it loops and play the anim
	background_anim.connect("animation_finished", background_anim, "play", ["Background"])
	background_anim.play("Background")
