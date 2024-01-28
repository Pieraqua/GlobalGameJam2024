extends Node2D

const ATK = 5
const RELOAD = 0.5

func _ready():
	$ReloadTimer.timeout.connect(_on_animation_finish)

func hit():
	if($ReloadTimer.is_stopped()):
		$AnimatedSprite2D.play()
		$ReloadTimer.start(RELOAD)
		for body in $Hitbox.get_overlapping_bodies():
			if body.has_method("hit"):
				body.hit(ATK)

func _on_animation_finish():
	$AnimatedSprite2D.stop()
