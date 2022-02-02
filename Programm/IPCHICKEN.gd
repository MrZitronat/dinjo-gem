extends RigidBody2D

var ei = preload("res://ei.tscn")
var eiRel = Vector2()
var onGround = false

func _ready():
	contact_monitor = true
	contacts_reported = 100

func _physics_process(delta):
	if Input.is_action_pressed("leftz") and linear_velocity.x > -300:
		linear_velocity.x -= 50
	if Input.is_action_pressed("right") and linear_velocity.x < 300:
		linear_velocity.x += 50
	if Input.is_action_pressed("down") and $Timer.time_left == 0:
		$Timer.start()
		var eiei = ei.instance()
		get_parent().get_node("chiggn").add_child(eiei)
	if Input.is_action_just_pressed("up") and onGround == true:
		linear_velocity.y = -300

	#angular_velocity = 0
	#rotation = 0




func _on_chiggn_body_entered(body):
	onGround = true


func _on_chiggn_body_exited(body):
	onGround = false


