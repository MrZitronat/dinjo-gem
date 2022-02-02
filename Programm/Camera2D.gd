extends Camera2D

var posDinjo = Vector2()
var posChicken = Vector2()
var zoomComp = [100,100]
var animTime = 0
export var decay = 0.1  # How quickly the shaking stops [0, 1].
export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
export var max_roll = 1  # Maximum rotation in radians (use sparingly).

var trauma = 0.0  # Current shake strength.

var trauma_power = 20



func _process(delta):
	posDinjo = get_parent().get_node("dintscho").position
	posChicken = get_parent().get_node("chiggn").position

	position = Vector2((posDinjo.x + posChicken.x) / 2,(posDinjo.y + posChicken.y) / 2)
	zoomComp = [(abs(posDinjo.x - posChicken.x) + 200) / OS.window_size.x,(abs(posDinjo.y - posChicken.y) + 200) / OS.window_size.y]
	if zoomComp.max() < 1:
		zoom = Vector2(1,1)
	else:
		zoom = Vector2(zoomComp.max(),zoomComp.max())
	
	if EiGlobal.shake:
		add_trauma(1000)
		EiGlobal.shake = false
	
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()


func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)


func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)
