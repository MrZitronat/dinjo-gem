extends Sprite
var lavaScene = preload("res://lava.tscn")
var x = 0

func _physics_process(delta):
	if randi() % 500 > 497:
		randomize()
		var lava = lavaScene.instance()
		lava.position = Vector2(1380,3670)
		x = randi() % 8000
		lava.linear_velocity = Vector2(x - 4000,-1 * randi() % 5000)
		get_parent().get_node("laOOOOVA INSTANCEs").add_child(lava)
