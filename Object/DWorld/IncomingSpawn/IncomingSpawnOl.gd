extends Position2D

onready var end_pos := $EndPos

var active := true

var sequence_path := "res://Object/Sequence/Sequences/"

var difficulties = {
	1: 0,
	2: 0,
	3: 0
}

# The current difficulty from main
onready var difficulty: int = get_parent().difficulty
# Once the value reaches this value the difficulty increases
const difficulty_up := 5

func transition_done():
	spawn_random_sequence()

func spawn_random_sequence():
	add_difficulty()
	
	var difficulty_pool := []
	
	# For each difficulty
	for key in difficulties.keys():
		# Get the current amount of values to put in the pool
		var value: int = difficulties[key]
		# Put the name in the pool for the amount of times in the difficulties
		for index in range(0, value):
			difficulty_pool.append(G.difficulty_name[key])
	
	var difficulty: String = G.random_in_array(difficulty_pool)
	var possible_sequences: Array = G.get_files(sequence_path + difficulty)
	var sequence_path: String = G.random_in_array(possible_sequences)
	var sequence: Sequence = G.make_node(sequence_path)
	var spawn_point = Vector2(position.x, position.y)
	sequence.position = spawn_point
	get_parent().add_child(sequence)

func add_difficulty():
	# If the difficulty should rank up and this is not the last difficulty
	if difficulties[difficulty] >= difficulty_up and difficulties.keys().size() > difficulty:
		difficulty += 1
	difficulties[difficulty] += 1
	
#func spawn_sequence(name: String, difficulty: String):
#	var spawn_point = Vector2(position.x, position.y)
#	var sequence = make_sequence(name + ".tscn", difficulty)
#	sequence.position = spawn_point
#	get_parent().add_child(sequence)

func player_death():
	active = false

func _on_DestroyLine_body_exited(body):
	if body.get_class() == "SpawnPoint":
		spawn_random_sequence()
