extends Node2D

signal map_loaded

@onready var wave_system = get_node("../SistemaDeWave")

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("map_loaded")
	wave_system.spawn_wave.connect(on_spawn_wave)
	

func on_spawn_wave(wave : String):
	var wave_scene = load(wave)
	if wave_scene != null:
		var instance = wave_scene.instantiate()
		add_child(instance)
