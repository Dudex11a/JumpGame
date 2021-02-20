extends Collectible

func collected():
	get_tree().call_group("Score", "add_score", 1)
	queue_free()
