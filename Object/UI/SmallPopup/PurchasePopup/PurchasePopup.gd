extends "res://Object/UI/SmallPopup/SmallPopup.gd"

onready var cost_label: = $PanelContainer/VBoxContainer/Cost/CostText

var cost: = 0 setget set_cost

signal purchase

func _on_Purchase_pressed():
	emit_signal("purchase")
	close_popup()

func set_cost(val: int):
	cost = val
	if cost_label:
		cost_label.text = String(cost)
