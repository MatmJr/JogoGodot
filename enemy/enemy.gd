extends CharacterBody2D

@export var SPEED: float = 100
var random_direction: Vector2 = Vector2.ZERO
var change_direction_timer: float = 0.0

func _ready() -> void:
	change_direction_timer = randf_range(0,1.0)

func _physics_process(delta: float) -> void:
	change_direction_timer -= delta
	
	if change_direction_timer <= 0:
		random_direction = Vector2(randf_range(-1.0,1.0), 
		randf_range(-1.0,1.0)).normalized()
		
		change_direction_timer = randf_range(0.1, 0.5)
		
	velocity = random_direction * SPEED
	move_and_slide()

@onready var WalkAnimation = $AnimatedSprite2D
func _process(delta: float) -> void:
	if velocity.length() > 0:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x >0:
				WalkAnimation.play("right")
			else:
				WalkAnimation.play("left")
		else:
			if velocity.y > 0:
				WalkAnimation.play("down")
			else:
				WalkAnimation.play("up")
