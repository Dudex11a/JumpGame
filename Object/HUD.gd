extends Control

onready var score := $Score
var score_prefix := ""

onready var time := $Time
onready var start_time: int

func _ready():
	score.text = score_prefix + "0"

func _process(delta):
	time.text = G.make_time(OS.get_ticks_msec() - start_time)

func score(value: int):
	score.text = score_prefix + String(value)
