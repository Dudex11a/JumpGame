extends Control

onready var background := $Background

onready var coin_amount := $CoinAmount
onready var anim_player_coin := $"AnimPlayerCoin"
onready var anim_player_text := $"AnimPlayerText"

export var coin_anim_percent := 0.0 setget animate_coin_amount
var previous_currency: int = 0
var new_currency: int

func _ready():
	var anim = anim_player_coin.get_animation("CoinSpin")
	
	set_property()

func set_property():
	previous_currency = new_currency
	new_currency = S.currency
	anim_player_coin.play("CoinSpin")
	anim_player_text.play("CoinAmount")

func animate_coin_amount(percent: float):
	var anim_coin_amount = int(previous_currency + (new_currency - previous_currency) * percent)
	if coin_amount:
		coin_amount.text = String(anim_coin_amount)


func _input(event):
	# Spin coin if globals is clicked
	if event is InputEventMouseButton:
		var img_pressed = true
		for axis in ["x", "y"]:
			var within : bool = (event.position[axis] >= rect_global_position[axis]) && (event.position[axis] <= rect_global_position[axis] + rect_size[axis])
			if not within: img_pressed = false
		if img_pressed and event.pressed:
			anim_player_coin.stop()
			anim_player_coin.play("CoinSpin")
