extends Position2D

export var sequence_group_scene: PackedScene
onready var sequence_group: SequenceGroup = sequence_group_scene.instance()
onready var world: = get_parent().get_parent()

var allow_spawning = true
var seq_created: = 0
# The amount of Tri there are
const tri_amount: = 4
# This is used to determine which tri spawns when spawning a Tri
var tri_round: = 0

func _ready():
	spawn_sequence()

# Spawn the correct sequence
func spawn_sequence():
	if allow_spawning:
		var seq = get_seq()
		print(seq.filename)
		call_deferred("add_child", seq)
		seq_created += 1

# Get sequence while being scaled
func get_seq():
	var seq_id
	# Every forth sequence
#	if true:
	if seq_created % 4 == 3:
		# Get Tri Sequence
		var tris: Array = world.tri
		# Spawn Tri based on tri round
		var tri_to_check: = tri_round
		var i: = 0
		while i < tri_amount:
			i += 1
			if not tris[tri_to_check]:
				print("Regular Tri selection")
				# Set the sequence to spawn to this Tri that hasn't been collected
				seq_id = sequence_group.tri_seqs[tri_to_check]
				# End loop
				i = 4
			tri_to_check = tri_add(tri_to_check)
		# If all Tri are collect spawn the Tri based on the round
		if not seq_id:
			print("All Tri are collected, defaulting to regular Tri")
			seq_id = sequence_group.tri_seqs[tri_round]
		# Interate on the tri round to produce a different
		# Tri next time
		iterate_round()
	
	# Get sequence by difficulty
	if not seq_id:
		# Put the 3 different difficulties in this array
		# and pick a random one
		var weights: = []
		var weights_added: = [0, 0, 0]
		# Difficulty 1
		# seq_created 0 = 10, 5 = 5
		weights_added[0] = abs(int(min(5, seq_created)) - 5) + 5
		# Difficulty 2
		# seq_created 1 = 0, 10 = 10, 20 = 5, 25 = 5
		weights_added[1] = min(seq_created, 10 - min(5, seq_created - 10))
		# Difficulty 3
		# seq_created 1 = 0, 10 = 0, 30 = 15
		weights_added[2] = clamp(round((seq_created - 10) * (15.0 / 20.0)), 0, 15)
		# Wow, that was pretty math.
		# Assign vales to weights
		for i in range(weights_added.size()):
			var val = weights_added[i]
			for i2 in range(val):
				weights.append(i)
		# Select random difficulty
		var difficulty = G.random_in_array(weights)
		# Get a random id from the correct difficulty array
		seq_id = G.random_in_array(sequence_group.seqs[difficulty])
	# If a sequence was found prior return that
	if seq_id:
		return load_seq(seq_id)
	# Otherwise return this value
	return load_seq(G.random_in_array(sequence_group.seqs[0]))

#func debug_2():
#	get_seq()
#	seq_created += 1

func iterate_round():
	tri_round = tri_add(tri_round)

# Quick function to make sure Tri related things stay under 4
func tri_add(val: int):
	return (val + 1) % tri_amount

func load_seq(id: String):
	return load(P.make_seq_path(id)).instance()

func player_death():
	allow_spawning = false
