extends CharacterBody2D

signal heartChanged

const SPEED = 300.0

@export var maxHealth = 3
var currentHealth

@onready var animation = $AnimationPlayer
@onready var weapon = $PlayerWeapon
@onready var WalkAnimation = $AnimatedSprite2D

enum States {IDLE, WALK, ATTACK}


var current_state = States.IDLE
var last_direction = "qualquercoisa"

var direction_actions = {
	"ui_right": {"name": "right", "vector": Vector2.RIGHT},
	"ui_left": {"name": "left", "vector": Vector2.LEFT},
	"ui_down": {"name": "down", "vector": Vector2.DOWN},
	"ui_up": {"name": "up", "vector": Vector2.UP}
}

func _ready() -> void:
	currentHealth = maxHealth
	weapon.visible = false
	last_direction = WalkAnimation.animation

func _on_hurt_box_area_entered(area):
	if area.name != "hitBox": return

	currentHealth -= 1
	heartChanged.emit(currentHealth)
	print_debug(currentHealth)
	
	var knockback_force = 1000
	var knockback_direction = (global_position - area.global_position).normalized()
	velocity = knockback_force * knockback_direction
	move_and_slide()

	if currentHealth <= 0:
		get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	var input_direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()

	velocity = input_direction * SPEED if input_direction else velocity.move_toward(Vector2.ZERO, SPEED)
	
	if input_direction:
		_update_last_direction(input_direction)

	move_and_slide()

func _update_last_direction(input_direction: Vector2):
	for action in direction_actions.values():
		if action["vector"].dot(input_direction) > 0:
			last_direction = action["name"]
			break

func _update_state():
	if Input.is_action_pressed("attack"):
		current_state = States.ATTACK
	elif Input.get_axis("ui_left", "ui_right") or Input.get_axis("ui_up", "ui_down"):
		current_state = States.WALK
	else:
		current_state = States.IDLE

func _handle_animation():
	weapon.visible = current_state == States.ATTACK
	match current_state:
		States.IDLE:
			WalkAnimation.stop()
		States.WALK:
			WalkAnimation.play(last_direction)
		States.ATTACK:
			WalkAnimation.play(last_direction)
			animation.play("attack" + last_direction.capitalize())

func _process(delta):
	_update_state()
	_handle_animation()
