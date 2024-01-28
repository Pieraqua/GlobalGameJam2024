extends CharacterBody2D

const SPEED = 300.0
const MAX_HP = 100

var hitpoints = MAX_HP
var damage_sources : Array[int] = []

@onready var Globals = get_node("/root/MainScene")
@onready var UI_HP = get_node("/root/MainScene/UI/Container_pontos/HPBar")
@onready var _animated_sprite = $AnimatedSprite2D
@onready var horn = get_node("WeaponHolster")

func _ready():
	Globals.set("player", self)
	hitpoints = MAX_HP
	UI_HP.value = hitpoints
	_animated_sprite.play("idle")

func _process(delta):
	if !damage_sources.is_empty():
		hitpoints -= damage_sources.max()*delta
		UI_HP.value = hitpoints
		if hitpoints < 0:
			print("Fim de jogo!")
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if direction:
		velocity = direction * SPEED
		if direction.x > 0:
			_animated_sprite.play("run_right")
		elif direction.x < 0:
			_animated_sprite.play("run_left")
		elif direction.y > 0:
			_animated_sprite.play("run_forward")
		elif direction.y < 0:
			_animated_sprite.play("run_back")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		_animated_sprite.play("idle")
	
	if horn != null:
		horn.rotation = mouse_direction.angle()
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

func _input(event):
	if event.is_action_pressed("attack"):
		if $WeaponHolster.get_child(0).has_method("hit"):
			$WeaponHolster.get_child(0).hit()


