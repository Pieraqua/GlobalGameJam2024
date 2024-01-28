extends CharacterBody2D

const SPEED = 100.0
const ATK = 5
const HP_MAX = 10

var hitpoints = HP_MAX
var dead = false

@onready var Globals = get_node("/root/MainScene")
@onready var player = Globals.get("player")

# death animation frames and fps
const N_FRAMES = 17.0
const FPS = 10.0

func _ready():
	$AnimatedSprite2D.play("walk")
	$DeathTimer.timeout.connect(really_die)
	

func die():
	remove_child($CollisionShape2D)
	$AnimatedSprite2D.play("defeat")
	$DeathTimer.start(N_FRAMES/FPS)
	dead = true
	
	
func really_die():
	var parent = get_parent()
	get_parent().get_parent().remove_child(parent)
	
	
func hit(damage):
	if(hitpoints <= damage):
		die()
	else:
		hitpoints -= damage

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = global_position.direction_to(player.global_position)
	if direction and !dead:
		velocity = direction * SPEED
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
			
	move_and_slide()
