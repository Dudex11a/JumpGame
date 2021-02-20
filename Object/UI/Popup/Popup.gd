extends VBoxContainer

onready var anim_player: = $AnimationPlayer

func _ready():
	anim_player.play("TransitionIn")

func _input(event):
	# If tapped then close out of popup
	if event.is_action_released("jump") and !anim_player.is_playing():
		anim_player.stop()
		anim_player.play("TransitionOut")
		yield(anim_player, "animation_finished")
		queue_free()
