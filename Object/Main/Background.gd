extends CanvasLayer

onready var color := $Color
onready var anim := $BackgroundAnimation
onready var clouds := $Clouds

func _ready():
	# Connect background anim so it loops and play the anim
	anim.connect("animation_finished", anim, "play", ["Background"])
	anim.play("Background")

func player_death():
	color.material = null
	color.modulate = Color(1, 0, 0)
	clouds.modulate = Color(0, 0, 0, .4)
	
