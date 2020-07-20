extends Polygon2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

signal finished_in
signal finished_out
signal transition_end

var polygon_queue: Array

func _ready():	
	position = get_viewport().size / 2
	
	anim_player.play("TransitionIn")
	# How much px it should increment each time
	var increment := 50
	# How big the polygon should get
	# (This is a minimum amount, I don't care how big it gets as long as it's big enough)
	var destination_px := 1000
	# Calculate the amount of polys to generate
	# (This is the maximum amount of times it takes to reach the destination_px)
	var amount_of_polygons: int = floor(destination_px / minimum_increment(increment))
	# I initialize it here first so the loop uses the first thing in the array as a base
	polygon_queue = [increment_polygon(polygon, increment)]
	for i in range(1, amount_of_polygons + 1):
		polygon_queue.append(increment_polygon(polygon_queue[i - 1], increment))
	
	transition()

func transition(anim: String = "TransitionIn"):
	var anim_length := anim_player.get_animation(anim).length
	var individual_length: float = anim_length / polygon_queue.size()
	for poly in polygon_queue:
		polygon = poly
		yield(get_tree().create_timer(0.01), "timeout")
	emit_signal("transition_end")
	
func transition_out():
	polygon_queue.invert()
	transition("TransitionOut")
	yield(self, "transition_end")
	anim_player.stop(true)
	queue_free()

func animation_finished(anim_name: String):
	emit_signal("finished_in")
	anim_player.play("TransitionOut")
	transition_out()

# I use a function here if I want to change the minimum later down the line
func minimum_increment(increment: float) -> float:
	return increment / 2

func increment_polygon(old_polygon: PoolVector2Array , increment: float) -> PoolVector2Array:
	var polygon := old_polygon
	for i in range(0, polygon.size()):
		polygon[i] = increment_point(polygon[i], increment)
	return polygon
	

func increment_point(point: Vector2, increment: float) -> Vector2:
	var vector := point
	vector.x = random_increment(point.x, increment)
	vector.y = random_increment(point.y, increment)
	return vector

func random_increment(base: float, increment: float) -> float:
	var value := abs(base)
	var modifier := base / value # This will be positive or negative one so it remembers it later
	
	# 80%
	var should_increment: bool = G.rng.randi_range(0, 100) <= 80
	if should_increment:
		# Increment it by the "increment" amount
		value = G.rng.randf_range(value + (minimum_increment(increment)), value + increment)
	value *= modifier
	return value
