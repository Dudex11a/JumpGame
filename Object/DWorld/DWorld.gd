extends Node
class_name DWorld

onready var hud_node: = $World/Camera2D/HUD
onready var results_node: = $World/Camera2D/Results
onready var incoming_spawn: = $World/IncomingSpawn

export var world_name: String = name
var score: = 0 setget set_score
# Tri collected, rygb
var tri: Array = [false, false, false, false]
var elapsed_time: int = 0 setget set_time

onready var start_time: = OS.get_ticks_msec()
var allow_update_time: = true

# Sequences pass (used for difficulty)
var seq_passed: int = 0

func _ready():
	# Start timer
	update_time()
	# Store what scene the restart button will restart to
	results_node.restart_res = load(filename)

func set_score(val: int):
	score = val
	
func set_time(val: int):
	elapsed_time = val
	hud_node.elapsed_time = elapsed_time

func update_time():
	if allow_update_time:
		yield(get_tree().create_timer(0.5), "timeout")
		set_time(OS.get_ticks_msec() - start_time)
		update_time()

func game_over():
	results_node.visible = true
	# Change z-index of hud so it'd visible over
	# everything else
	hud_node.z_index = 9
	S.currency += score
	# Handle Highscore
	# Get highscore and if it's lower than the current score
	# then set the new highscore
	var hs = S.get_world_val(world_name, "highscore")
	if hs is int or hs is float:
		if score > hs:
			S.set_world_val(world_name, "highscore", score)
	else:
		S.set_world_val(world_name, "highscore", score)
	
func player_death():
	allow_update_time = false

# Destroy and score objects passing the line
func _on_DeathCollision_body_entered(body):
	if body is SpawnPoint:
		incoming_spawn.spawn_sequence()
		seq_passed += 1
	# The reason this isn't elif is because I need to
	# despawn the endpoint as well after spawning the next sequence
	if body is Actor:
		body.queue_free()

func add_score(increment: int):
	set_score(score + increment)
	get_tree().call_group("Score", "score_set", score)
