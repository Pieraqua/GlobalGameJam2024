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
	velocity = Vector2(0,0)
	
	
func really_die():
	var parent = get_parent()
	get_parent().get_parent().remove_child(parent)
	
	
func hit(damage):
	if(hitpoints <= damage):
		die()
	else:
		hitpoints -= damage

func _process(_delta):
	var viewport_size = get_viewport_rect().size
	var show_arrow = false
	var arrow_pos = get_viewport_rect().size/2 +  self.global_position - player.global_position
	
	# Flecha para a direita
	if(arrow_pos.x > viewport_size.x - 4 * 
		$AnimatedSprite2D.get_sprite_frames().get_frame_texture("walk",0).get_size().x):
		arrow_pos.x = viewport_size.x - $CanvasLayer/Frecha.get_rect().size.x + 10
		show_arrow = true
		$CanvasLayer/Frecha.set_rotation_degrees(90)
	# Flecha para a esquerda
	if(arrow_pos.x < 4 * $AnimatedSprite2D.get_sprite_frames().get_frame_texture("walk",0).get_size().x):
		arrow_pos.x = 0 + 4
		show_arrow = true
		$CanvasLayer/Frecha.set_rotation_degrees(-90)
	# Flecha para baixo
	if(arrow_pos.y > viewport_size.y - 
		2 * $AnimatedSprite2D.get_sprite_frames().get_frame_texture("walk",0).get_size().y):
		arrow_pos.y = viewport_size.y - 4#- $CanvasLayer/Frecha.get_rect().size.y
		$CanvasLayer/Frecha.set_rotation_degrees(180)
		
		show_arrow = true
	# Flecha para cima
	if(arrow_pos.y < 2 * $AnimatedSprite2D.get_sprite_frames().get_frame_texture("walk",0).get_size().y):
		arrow_pos.y = 0 + 4
		show_arrow = true
		$CanvasLayer/Frecha.set_rotation_degrees(0)
	
	if show_arrow:
		$CanvasLayer/Frecha.position = arrow_pos
	else:
		$CanvasLayer/Frecha.position = get_viewport_rect().size
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
