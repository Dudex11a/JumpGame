extends Node2D

onready var score_node := $Contents/Score
var score_node_prefix := ""

onready var time_node := $Contents/Time
onready var start_time: int
var elapsed_time: int = 0 setget set_time

var score: = 0 setget set_score

var allow_update_time := true

func _ready():
	set_score(0)
#	update_time()

func set_score(val: int):
	score = val
	score_node.text = score_node_prefix + String(val)

func set_time(val: int):
	elapsed_time = val
	time_node.text = G.make_time(elapsed_time)

func score_set(score: int):
	set_score(score)

func game_over():
	allow_update_time = false
