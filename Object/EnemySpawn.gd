extends Position2D

onready var end_pos := $EndPos

var active := true

var sequence_path := "res://Object/Sequence/Sequences/"

var easy := 1
var normal := 0
var hard := 0

var difficulty_increase := 4

func _ready():
	yield(get_tree().create_timer(1.0), "timeout")
	spawn_random_sequence()

#func make_sequence(file: String, folder: String) -> Node2D:
#	var path := sequence_path + folder + "/"
#	var sequence_resource := load(path + file)
#	return sequence_resource.instance()

func spawn_random_sequence():
	var difficulties := []
	for index in range(0, easy):
		difficulties.append("easy")
	for index in range(0, normal):
		difficulties.append("normal")
	for index in range(0, hard):
		difficulties.append("hard")
	# Random difficulty
	var difficulty: String = G.random_in_array(difficulties)
	var possible_sequences: Array = G.get_files(sequence_path + difficulty)
	var sequence_path: String = G.random_in_array(possible_sequences)
	var sequence: Sequence = G.make_node(sequence_path)
	var spawn_point = Vector2(position.x, position.y)
	sequence.position = spawn_point
	get_parent().add_child(sequence)
	add_difficulty()

func add_difficulty():
	if easy >= difficulty_increase:
		if normal >= difficulty_increase:
			hard += 1
			return
		normal += 1
		return
	easy += 1

#func spawn_sequence(name: String, difficulty: String):
#	var spawn_point = Vector2(position.x, position.y)
#	var sequence = make_sequence(name + ".tscn", difficulty)
#	sequence.position = spawn_point
#	get_parent().add_child(sequence)

func player_collision(collider):
	active = false

func _on_DestroyLine_body_exited(body):
	if body.get_class() == "EndPoint":
		spawn_random_sequence()
