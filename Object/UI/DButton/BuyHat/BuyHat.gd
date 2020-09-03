extends DButton
class_name BuyHat

export var cost: int = 40 setget set_cost
onready var container := $Container
onready var name_label := container.get_node("Name")
onready var cost_label := container.get_node("Cost")

signal bought

func set_cost(new_cost: int):
	cost = new_cost
	# Remove cost if 0, this will make it easier to indicate that it was already bought
	if cost == 0:
		# Remove all children that aren't the name
		for child in container.get_children():
			if child != name_label:
				child.queue_free()
	else:
		cost_label.text = String(cost)

func set_hat_name(new_name: String):
	name_label.text = new_name

func get_hat_name() -> String:
	return name_label.text

#func buy_hat():
#	if S.currency >= cost:
#		var success := S.add_hat(get_hat_name())
#		if success:
#			S.currency -= cost
#			G.A.play_sound(buy_sound, 1)
#		else:
#			# Has already been bought
#			G.A.play_sound(buy_sound, 1)
#	else:
#		G.A.play_sound(error_sound, 1)
#	update_cost()
#	emit_signal("bought")

# Update the cost, this is mainly for if it has been bought
func update_cost():
	if S.obtained_hats.has(get_hat_name()):
		self.cost = 0
