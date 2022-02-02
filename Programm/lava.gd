extends RigidBody2D

func _process(delta):
	LavaGlobal.pos = position
	LavaGlobal.lavaPos = get_parent().position

func _on_Timer_timeout():
	print("OMG LOAVA HAT DESPAWNIERT")
	queue_free()
