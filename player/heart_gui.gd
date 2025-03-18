extends Panel

@onready var sprite = $Sprite2D

func update(estado: bool):
	if estado: sprite.frame = 4
	else: sprite.frame = 0
