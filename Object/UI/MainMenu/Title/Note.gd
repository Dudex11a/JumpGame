extends Control

# Remove "Note" to get the character that represents the note
onready var note_char: String = name.replace("Note", "")
onready var sprite: Sprite = get_node("../" + note_char)
onready var spr_mat: Material = sprite.material
# How far up the sprite should go when pressed
const spr_bump: = -20.0
const spr_speed: = 1000.0

var pressed: = false setget set_pressed
var index_pressed: int = -1
signal button_down
signal button_up

onready var title: Control = get_parent()
onready var audio: = $Audio
export var sample: AudioStreamSample

func _ready():
	audio.stream = sample
	audio.stream.loop_begin = 12774
	audio.stream.loop_end = 17578

func _input(event):
	# This will set pressed if the node is touched within it's size.
	var c = event is InputEventScreenTouch or event is InputEventScreenDrag
	c = c and title.active
	if c:
		# InputEventScreenDrag does not have a "pressed" property
		# I address that here
		var event_pressed: bool
		if event is InputEventScreenTouch:
			event_pressed = event.pressed
		else:
			event_pressed = true
		if event_pressed:
			# Make some shorthand
			var p = rect_global_position
			var p2 = p + rect_size
			var e_p = event.position
			# If the input event is not within the area of the node, it is not tapped
			var in_area: = true
			for a in range(2):
				if p[a] > e_p[a] or p2[a] < e_p[a]: in_area = false
			if in_area:
				# Press or drag inside
				self.pressed = true
				index_pressed = event.index
			else:
				# If drag outside of area and it was the finger that pressed the note
				if event.index == index_pressed:
					self.pressed = false
		else:
			# If release press
			if event.index == index_pressed:
				self.pressed = false

func _process(delta):
	# If note is pressed, move note up a little.
	if pressed:
		if sprite.offset.y > spr_bump:
			sprite.offset.y -= spr_speed * delta
		else:
			sprite.offset.y = spr_bump
	# If not move back down
	else:
		if sprite.offset.y < 0:
			sprite.offset.y += spr_speed * delta
		else:
			sprite.offset.y = 0

func set_pressed(val):
	# Initial press
	if val and not pressed:
		emit_signal("button_down")
	pressed = val
	if not pressed:
		emit_signal("button_up")
		index_pressed = -1


func _on_Note_button_down():
	# Anim
	title.anim_player.stop()
	title.anim_player.play("WiggleStop")
	# Sound
	if not audio.playing:
		audio.play()

func _on_Note_button_up():
	# I have the yield hear because without it, if you drag across the screen
	# really fast some sounds won't stop. I think this is caused because you
	# can't stop the sound
	yield(get_tree().create_timer(0.04), "timeout")
	audio.stop()
	# Log the note press in the title for cheat codes
	title.log_note(note_char)
