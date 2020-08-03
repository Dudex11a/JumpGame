extends Node2D

onready var head := $Head
onready var body := $Body
onready var tail := $Tail

func _physics_process(delta):
	# Wobble anim
	wobble(body)
	wobble(tail)

func wobble(node: Node2D, px: float = 5):
	var amount: float = sin(node.global_position.x / (OS.window_size.x / 20)) * px
	node.position.y = head.position.y + amount
