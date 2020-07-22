extends Node2D

onready var player := $Player
onready var hud := $HUDLayer/HUD
onready var results := $Results
onready var enemy_spawn := $EnemySpawn
onready var clouds: Array = [
	$Collision/CollisionBottom/Clouds,
	$Collision/CollisionTop/Clouds
]
onready var clouds2: Array = [
	$Collision/CollisionBottom/Clouds2,
	$Collision/CollisionTop/Clouds2
]

onready var start_time := OS.get_ticks_msec()

var difficulty := 1

var is_game_over := false
var max_speed_up := G.max_speed_up
var how_many_to_max := G.how_many_to_max

func _ready():
	hud.rect_size = get_viewport_rect().size
	results.rect_size = get_viewport_rect().size
	hud.start_time = start_time

func _process(delta):
	advance_clouds(clouds, 1)
	advance_clouds(clouds2, -2)

func lose():
	G.change_to_main_menu()

func game_over():
	# Show results
	results.visible = true
	# Display HUD over UI
	$HUDLayer.z_index = 3

# Score points
func _PlayerLine_body_exited(body):
	if body.get_class() == "EndPoint":
		# Add points from sequence to score
		player.score += body.get_parent().points

func _on_DestroyLine_body_exited(body):
	if body is Enemy:
		body.queue_free()

func restart():
	G.start_game()

func goto_mainmenu():
	G.change_to_main_menu()

func advance_clouds(clouds: Array, speed: float):
	for cloud in clouds:
		cloud.region_rect.position.x += speed
