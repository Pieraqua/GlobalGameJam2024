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

func _process(delta):
	var viewport_size = get_viewport_rect().size
	var show_arrow = false
	var arrow_pos = get_viewport_rect().size/2 +  self.global_position - player.global_position
	if(arrow_pos.x > viewport_size.x - 64):
		arrow_pos.x = viewport_size.x - $CanvasLayer/ColorRect.size.x
		show_arrow = true
	if(arrow_pos.x < 64):
		arrow_pos.x = 0
		show_arrow = true
	if(arrow_pos.y > viewport_size.y - 64):
		arrow_pos.y = viewport_size.y - $CanvasLayer/ColorRect.size.y
		show_arrow = true
	if(arrow_pos.y < 64):
		arrow_pos.y = 0
		show_arrow = true
	
	if show_arrow:
		$CanvasLayer/ColorRect.position = arrow_pos
	else:
		$CanvasLayer/ColorRect.position = get_viewport_rect().size
	pass

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
