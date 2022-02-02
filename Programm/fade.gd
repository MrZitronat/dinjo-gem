extends Sprite

func _physics_process(delta):
	position.y = OS.window_size.y - 120
	position.x = OS.window_size.x / 2
	scale.x = 2048
