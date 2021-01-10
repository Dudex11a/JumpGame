extends Node2D
class_name SceneTransition

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var screne_capture: Sprite = $ScreneCapture

signal finished_in
signal finished_out
signal transition_end

func _ready():
	transition()

func transition(anim_in: = true):
	# Create animation name from bool
	var anim = "Transition"
	if anim_in:
		anim += "In"
	else:
		anim += "Out"
	# Play animation
	anim_player.stop()
	anim_player.play(anim)
	if anim_in:
		# Get screenshot
		var img = get_viewport().get_texture().get_data()
		# Yield for screenshot?
#		yield(get_tree(), "idle_frame")
		# Create texture from screenshot
		var tex = ImageTexture.new()
		tex.create_from_image(img)
		# Apply texture to screen
		screne_capture.texture = tex
		G.A.play_sound(load("res://Sound/TransitionIn.wav"), 1)
	else:
		# Remove screenshot
		screne_capture.texture = null
		G.A.play_sound(load("res://Sound/TransitionOut.wav"), 1)
	# Wait until the anim is finished
	yield(anim_player, "animation_finished")
	# Emit correct signals for transitioning in and out
	if anim_in:
		emit_signal("finished_in")
		# Start the end transition
		transition(false)
	else:
		emit_signal("finished_out")
	emit_signal("transition_end")
