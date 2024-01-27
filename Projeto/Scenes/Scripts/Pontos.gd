extends Node

var current_points = 0
var current_combo = 1
var character_alive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_monster_killed(monster_type):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if character_alive:
		current_points += current_combo * delta
	pass

func _on_map_loaded():
	character_alive = true
	pass # Replace with function body.
