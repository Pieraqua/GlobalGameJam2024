extends Node

var Waves : Array[Array] = [
	[295, "res://Scenes/Waves/Wave_2.tscn"],
	[290, "res://Scenes/Waves/Wave_1.tscn"],
	[285, "res://Scenes/Waves/Wave_2.tscn"],
	[280, "res://Scenes/Waves/Wave_1.tscn"]
]

signal spawn_wave(String)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer3min.start(300)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for wave in Waves:
		if wave[0] > $Timer3min.get_time_left():
			emit_signal("spawn_wave", wave[1])
			Waves.erase(wave)
