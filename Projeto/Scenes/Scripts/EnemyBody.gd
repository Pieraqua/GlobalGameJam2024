extends CharacterBody2D


const SPEED = 100.0

@onready var Globals = get_node("/root/MainScene")
@onready var player = Globals.get("player")


func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = global_position.direction_to(player.global_position)
	if direction:
		velocity = direction * SPEED

	move_and_slide()
