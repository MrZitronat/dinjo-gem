extends RigidBody2D

var soos = false

func _on_Timer_timeout():
	queue_free()

func _on_Timer2_timeout():
	soos = true
	$Particles2D.emitting = true
	EiGlobal.pos = position
	EiGlobal.chiggnPos = get_parent().position
	EiGlobal.shake = true
	$AudioStreamPlayer2D.play()
	

func _physics_process(delta):
	if soos and $CollisionPolygon2D.scale.x < 2:
		$CollisionPolygon2D.scale += Vector2(0.2,0.2)
		$Sprite.scale += Vector2(0.2,0.2)
	
