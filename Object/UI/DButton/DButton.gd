extends Button
class_name DButton

export var press_down_sound: AudioStream
export var press_up_sound: AudioStream
onready var label: = $Label
onready var anim_player: = $AnimationPlayer

export var shader_rad: float = 0 setget set_shader_radius

func _ready():
	# For some reason this doesn't default to 0 on some buttons
	material.set("shader_param/radius", 0)
	set_shader_res()
	replace_button_text()
	# Have to do this manually here for some reason
	connect("button_down", self, "_on_Button_button_down")
	connect("button_up", self, "_on_Button_button_up")

func _on_Button_button_down():
	var mouse_pos = (get_global_mouse_position() - rect_global_position) / rect_size;
	material.set("shader_param/mouse_pos", mouse_pos);
	anim_player.stop()
	anim_player.play("ButtonDown")
	G.A.play_sound(press_down_sound)
	
func _on_Button_button_up():
	anim_player.stop()
	anim_player.play("ButtonUp")
	G.A.play_sound(press_up_sound)
	
func set_text(val):
	replace_button_text(val)

func replace_button_text(val: = text):
	label.text = val
	text = ""

func set_shader_radius(val: float):
	shader_rad = val
	material.set("shader_param/radius", val);

func set_shader_res():
	material.set("shader_param/node_size", rect_size)
