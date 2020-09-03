extends Node
class_name Audio

onready var players := [
	$Menu,
	$Menu2
]

func play_sound(stream: AudioStream, player_id := 0):
	var player = players[player_id]
	if !player:
		player = $Menu
	player.stop()
	player.stream = stream
	player.play()
