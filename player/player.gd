extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var direction2 := Input.get_axis("ui_up", "ui_down")
	if direction2:
		velocity.y = direction2 * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()


@onready var WalkAnimation = $AnimatedSprite2D
func _process(delta):
	if Input.is_action_pressed("ui_down"):
		WalkAnimation.play("down")
	elif Input.is_action_pressed("ui_up"):
		WalkAnimation.play("up")
	elif Input.is_action_pressed("ui_right"):
		WalkAnimation.play("right")
	elif Input.is_action_pressed("ui_left"):
		WalkAnimation.play("left")
	else:
		WalkAnimation.stop()
