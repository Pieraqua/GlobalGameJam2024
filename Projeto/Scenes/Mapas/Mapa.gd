extends Node2D

signal map_loaded

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("map_loaded")
	pass # Replace with function body.

