extends CharacterBody2D

signal heartChanged
const SPEED = 300.0

@export var maxHealth = 3
@onready var currentHealth = maxHealth
@onready var animation = $AnimationPlayer
@onready var weapon = $PlayerWeapon

func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		print_debug(currentHealth)
		heartChanged.emit(currentHealth)
		if currentHealth <= 0:
			get_tree().reload_current_scene()

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

func _ready() -> void:
	weapon.visible = false

@onready var WalkAnimation = $AnimatedSprite2D
func _process(delta):
	if Input.is_action_pressed("ui_down"):
		WalkAnimation.play("down")
		if Input.is_action_pressed("attack"):
			animation.play("attackDown")
			weapon.visible = true
		else:
			weapon.visible = false
	elif Input.is_action_pressed("ui_up"):
		WalkAnimation.play("up")
		if Input.is_action_pressed("attack"):
			animation.play("attackUp")
			weapon.visible = true
		else:
			weapon.visible = false
	elif Input.is_action_pressed("ui_right"):
		WalkAnimation.play("right")
		if Input.is_action_pressed("attack"):
			animation.play("attackRight")
			weapon.visible = true
		else:
			weapon.visible = false
	elif Input.is_action_pressed("ui_left"):
		WalkAnimation.play("left")
		if Input.is_action_pressed("attack"):
			animation.play("attackLeft")
			weapon.visible = true
		else:
			weapon.visible = false
	else:
		WalkAnimation.stop()
