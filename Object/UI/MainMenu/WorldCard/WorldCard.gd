extends Control

onready var button := $Button

export var preview_image: StreamTexture
export var full_image: StreamTexture

export var world_name: String = "World Name"
export var difficulty: int = 0
export var cost: int = 10

var collected: int = 0
var high_scores: Array

signal pressed

func _ready():
	# Set card background
	if preview_image:
		button.material.set("shader_param/background", preview_image)
