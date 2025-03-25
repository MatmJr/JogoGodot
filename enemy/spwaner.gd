extends Node2D

## Carrega a cena do inimigo
#@export var enemy_scene: PackedScene = preload("res://enemy.tscn")
## Define o tempo de spawn em segundos
#@export var spawn_interval: float = 3.0
#
#func _ready() -> void:
	#var timer = Timer.new()
	#timer.wait_time = spawn_interval
	#timer.one_shot = false
	#timer.autostart = true
	#add_child(timer)
	#timer.connect("timeout", Callable(self, "_spawn_enemy"))
#
#func _spawn_enemy() -> void:
#
	#var viewport_rect: Rect2 = get_viewport().get_visible_rect()
#
	#var random_x = randf_range(viewport_rect.position.x, viewport_rect.position.x + viewport_rect.size.x)
	#var random_y = randf_range(viewport_rect.position.y, viewport_rect.position.y + viewport_rect.size.y)
	#var spawn_position = Vector2(random_x, random_y)
#
	#var enemy_instance = enemy_scene.instantiate()
	#enemy_instance.position = spawn_position
	#add_child(enemy_instance)
