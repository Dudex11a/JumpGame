extends Actor
class_name SpawnPoint
func get_class(): return "SpawnPoint"

onready var score_given: int = get_parent().score_given

func _ready():
	# Turn invisible if not debug
	if not OS.is_debug_build():
		visible = false

func _physics_process(delta):
	velocity.x = -speed

func player_death():
	self.active = false
	sprite.modulate.v = 0
