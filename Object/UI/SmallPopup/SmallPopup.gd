extends Control

onready var anim_player: = $AnimationPlayer
onready var panel_node: = $PanelContainer

export var close_tap: = 0

enum {
	TAP_ANYWHERE,
	TAP_OUTSIDE,
	TAP_INSIDE,
	TAP_NONE
}

signal close

func _ready():
	anim_player.play("TransitionIn")

func _input(event):
	# If tapped then close out of popup
	if event.is_action_released("jump"):
		match close_tap:
			0:
				close_popup()
			1, 2:
				var within: = G.within_box(
					get_viewport().get_mouse_position(),
					panel_node.rect_global_position,
					panel_node.rect_size
					)
				if not within && close_tap == 1:
					close_popup()
				if within && close_tap == 2:
					close_popup()

#func setup(pos: Vector2):
#	rect_position = pos
	
func close_popup():
	if !anim_player.is_playing():
		emit_signal("close")
		anim_player.stop()
		anim_player.play("TransitionOut")
		yield(anim_player, "animation_finished")
		queue_free()
