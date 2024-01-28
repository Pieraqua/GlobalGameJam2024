extends Node

const COMBO_MAX_TIME = 5
const COMBO_MIN = 1

var current_points = 0
var combo_time = 0
var character_alive = false
var current_combo = COMBO_MIN

signal update_points(int)
signal update_combo(int)

@onready var globals = get_node("/root/MainScene")

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_points(0)
	_on_increase_combo(0)
	pass # Replace with function body.
	
func on_game_start():
	current_points = 0
	combo_time = 0
	current_combo = COMBO_MIN
	_update_points(0)
	_on_increase_combo(0)

func _on_monster_killed(monster_type):
	var combo_raise = 1
	var pontos = 0
	
	if(monster_type <= globals.monsters.len()):
		pontos = globals.monsters[monster_type][0]
		combo_raise = globals.monsters[monster_type][1]
	else:
		print("_on_monster_killed: monster_type não registrado")
	
	_update_points(pontos)
	_on_increase_combo(combo_raise)
	pass

func _on_increase_combo(combo_raise : int):
	current_combo += combo_raise
	combo_time = COMBO_MAX_TIME
	emit_signal("update_combo", current_combo)

func _update_points(points : float):
	current_points += points
	emit_signal("update_points", current_points)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if character_alive:
		_update_points(current_combo * delta)
		combo_time -= delta
		if combo_time == 0:
			current_combo = COMBO_MIN
	pass

func _on_map_loaded():
	character_alive = true
	pass # Replace with function body.
