extends RigidBody2D

var direction = true
var directionOld = true #true > rechts, false > links
var dinoPos = Vector2()
var chiggnPos = Vector2()
var onGround = false
var respawnPos = null
var plsTeleportMeINeedHelp = false


func _physics_process(delta):
	if Input.is_action_pressed("A") and linear_velocity.x > -500:
		linear_velocity.x -= 50
		direction = false
	if Input.is_action_pressed("d") and linear_velocity.x < 500:
		linear_velocity.x += 50
		direction = true

	if Input.is_action_pressed("S"):
		#$CollisionShape2D.scale = Vector2(0.2,1.8)
		$"Der dinjo".scale = Vector2(1.8,0.2)
		$"Der dinjo".position.y = 20
		dinoPos = position
		chiggnPos = get_parent().get_node("chiggn").position
		if 0 + dinoPos.x < chiggnPos.x and chiggnPos.x < 100 + dinoPos.x and -30 + dinoPos.y < chiggnPos.y and chiggnPos.y < 20 + dinoPos.y and direction:
			get_parent().get_node("chiggn").linear_velocity = Vector2(2000, 300)

		if -100 + dinoPos.x < chiggnPos.x and chiggnPos.x < 0 + dinoPos.x and -30 + dinoPos.y < chiggnPos.y and chiggnPos.y < 20 + dinoPos.y and direction==false:
			get_parent().get_node("chiggn").linear_velocity = Vector2(-2000, 300)

	else:
		if direction: $"Der dinjo".scale = Vector2(1,1)
		else: $"Der dinjo".scale = Vector2(-1,1)
		#$CollisionShape2D.scale = Vector2(1,1)
		$"Der dinjo".position.y = -10
	if direction != directionOld:
		$"Der dinjo".scale.x *= -1
		directionOld=direction



	if Input.is_action_just_pressed("W") and onGround == true:
		linear_velocity.y = -500
	
	if Input.is_action_just_pressed("q"):
		var tilemap = get_parent().get_node("StaticBody2D2/TileMap")
		var world_pos = tilemap.world_to_map(position)
		var world_pos_down = Vector2(world_pos.x, world_pos.y + 1)
		
		if respawnPos:
			print("Respawned")
			plsTeleportMeINeedHelp = true
			tilemap.set_cellv(tilemap.world_to_map(respawnPos), -1)
			
		elif tilemap.get_cellv(world_pos) == -1 and tilemap.get_cellv(world_pos_down) != -1:
			print("Respawnpoitn was set")
			tilemap.set_cellv(world_pos, 2)
			respawnPos = position


	var chiggnY = get_parent().get_node("chiggn").position.y
	get_parent().get_node("CanvasLayer/fade").modulate.a = (chiggnY - 2000) / 3529


func _on_dintscho_body_entered(body):
	onGround = true

func _on_dintscho_body_exited(body):
	onGround = false

func _integrate_forces(state):
	if respawnPos and plsTeleportMeINeedHelp:
		state.transform = Transform(Transform2D(0, respawnPos))
		plsTeleportMeINeedHelp = false
		respawnPos = null
		position.normalized()

