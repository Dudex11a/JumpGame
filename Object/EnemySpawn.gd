extends Position2D

onready var end_pos := $EndPos
onready var timer := $Timer

var active := true

func enemy_object() -> KinematicBody2D:
	var enemy_resource := load("res://Object/Enemy/Enemy.tscn")
	return enemy_resource.instance()

func spawn_enemy():
#	var spawn_point := global_position + Vector2(
#		G.rng.randi_range(0, end_pos.position.x),
#		G.rng.randi_range(0, end_pos.position.y)
#	)
	var spawn_point = Vector2(position.x, position.y)
	var enemy = enemy_object()
	enemy.position = spawn_point
	get_parent().add_child(enemy)

func _on_Timer_timeout():
	if active:
		spawn_enemy()
		timer.start()

func player_collision(collider):
	active = false
