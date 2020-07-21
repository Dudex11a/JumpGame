extends Control

onready var score := $Score
var score_prefix := ""

onready var time := $Time
onready var start_time: int

var update_time := true

func _ready():
	score.text = score_prefix + "0"

func _process(delta):
	if update_time:
		time.text = G.make_time(OS.get_ticks_msec() - start_time)

func score(value: int):
	score.text = score_prefix + String(value)

func game_over():
	update_time = false
