extends Control
class_name WorldCard

onready var button := $Button
onready var tab_node: = $TabContainer
onready var cost_node := $TabContainer/Before/Cost
#onready var purchase_popup = load(P.purchase_popup_tscn).instance()

export var owned: bool = false setget set_owned

export var preview_image: StreamTexture
export var full_image: StreamTexture

export var world_name: String = "World Name"
export var world: PackedScene
export var difficulty: int = 0
export var cost: int = 10 setget set_cost

var collected: int = 0
var high_scores: Array

signal pressed
signal enter

func _ready():
	# Update cost label
	set_cost(cost)
	# Set card background
	if preview_image:
		button.material.set("shader_param/background", preview_image)
	# Update it it's already owned
	if S.get_world_val(world_name, "owned") or owned:
		unlock_world()

func set_cost(val: int):
	cost = val
	if cost_node:
		cost_node.text = String(val)

func set_owned(val: bool):
	owned = val
	if S.worlds.has(world_name):
		if S.worlds[world_name].owned == true:
			unlock_world()

func purchase():
	if S.currency >= cost:
		# This needs purchase popup
		S.currency -= cost
		unlock_world()
		# Add world owned to save
		if not S.worlds.has(world_name):
			S.worlds[world_name] = {}
		S.worlds[world_name].owned = true
	else:
		# Create text popup
		var text_popup = load(P.text_small_popup_tscn).instance()
		get_viewport().add_child(text_popup)
		var popup_pos: Vector2 = rect_global_position
		popup_pos.y += rect_size.y
		text_popup.rect_position = popup_pos
		text_popup.text = "Not enough money to purchase."
	
func pressed():
	if owned:
		emit_signal("enter")
	else:
		# Create purchase popup
		var purchase_popup = load(P.simple_purchase_popup_tscn).instance()
		get_viewport().add_child(purchase_popup)
		var popup_pos: Vector2 = rect_global_position
		popup_pos.y += rect_size.y
		purchase_popup.rect_position = popup_pos
		purchase_popup.connect("purchase", self, "purchase")

func unlock_world():
	owned = true
	if tab_node:
		tab_node.current_tab = 1

