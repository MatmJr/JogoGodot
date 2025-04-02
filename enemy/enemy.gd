extends CharacterBody2D

signal heartChanged

enum State { WANDER, CHASE }

@export var SPEED: float = 50
@export var chase_distance: float = 300

var current_state = State.WANDER
var random_direction: Vector2 = Vector2.ZERO
var change_direction_timer: float = 0.0

@export var maxHealth = 5
var currentHealth

@onready var WalkAnimation = $AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	currentHealth = maxHealth
	change_direction_timer = randf_range(0.1, 0.5)

func _physics_process(delta: float) -> void:
	player = get_tree().get_first_node_in_group("Player")
	var distance = global_position.distance_to(player.global_position)

	if distance <= chase_distance:
		current_state = State.CHASE
	else:
		current_state = State.WANDER

	match current_state:
		State.WANDER:
			_state_wander(delta)
		State.CHASE:
			_state_chase()

	move_and_slide()

func _state_wander(delta: float) -> void:
	change_direction_timer -= delta
	if change_direction_timer <= 0:
		random_direction = Vector2(randf_range(-1.0,1.0), randf_range(-1.0,1.0)).normalized()
		change_direction_timer = randf_range(0.1, 0.5)

	velocity = random_direction * SPEED

func _state_chase() -> void:
	var chase_direction = (player.global_position - global_position).normalized()
	velocity = chase_direction * SPEED

func _handle_animation() -> void:
	if velocity.length() > 0:
		if abs(velocity.x) > abs(velocity.y):
			WalkAnimation.play("right" if velocity.x > 0 else "left")
		else:
			WalkAnimation.play("down" if velocity.y > 0 else "up")
	else:
		WalkAnimation.stop()

func _process(delta: float) -> void:
	_handle_animation()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.name != "weaponHitBox": return

	currentHealth -= 1
	heartChanged.emit(currentHealth)
	print_debug(currentHealth)

	var knockback_force = 1000
	var knockback_direction = (global_position - area.global_position).normalized()
	velocity = knockback_direction * knockback_force
	move_and_slide()

	if currentHealth <= 0:
		queue_free()
