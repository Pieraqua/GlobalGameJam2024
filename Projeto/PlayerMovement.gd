extends CharacterBody2D

const SPEED = 300.0
const MAX_HP = 100

var hitpoints = MAX_HP
var damage_sources : Array[int] = []

@onready var Globals = get_node("/root/MainScene")

func _ready():
	Globals.set("player", self)
	hitpoints = MAX_HP

func _process(delta):
	if !damage_sources.is_empty():
		hitpoints -= damage_sources.max()*delta
		print(hitpoints)

func _physics_process(_delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body):
	var is_enemy = body.get_collision_layer() & 2
	
	if is_enemy:
		damage_sources.append(body.ATK)
		print("Taking damage from new source: " + str(body.ATK))


func _on_area_2d_body_exited(body):
	if body.ATK in damage_sources:
		print("Stopped taking damage from: " + str(body.ATK))
		damage_sources.erase(body.ATK)
