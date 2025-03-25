extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $Player

func _ready() -> void:
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.heartChanged.connect(heartsContainer.updateHearts)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
