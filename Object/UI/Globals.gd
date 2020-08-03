extends Control

onready var background := $Background

onready var coin_amount := $CoinAmount
onready var anim_player := $AnimationPlayer

export var coin_anim_percent := 0.0 setget animate_coin_amount
var previous_currency: int = 0
var new_currency: int

func _ready():
	set_property()

func set_property():
	previous_currency = new_currency
	new_currency = S.currency
	anim_player.play("CoinSpin")

func animate_coin_amount(percent: float):
	var anim_coin_amount = int(previous_currency + (new_currency - previous_currency) * percent)
	coin_amount.text = String(anim_coin_amount)


func goto_tab(extra_arg_0):
	pass # Replace with function body.
