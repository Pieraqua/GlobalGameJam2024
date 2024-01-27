extends Control

func _on_update_combo(current_combo : int):
	get_node("/root/MainScene/UI/Container_pontos/Texto_combo").text = "Combo: " + str(int(current_combo))
	
func _on_update_points(current_points : int):
	get_node("/root/MainScene/UI/Container_pontos/Texto_pontos").text = "Pontos: " + str(int(current_points))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
