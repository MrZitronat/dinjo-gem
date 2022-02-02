extends TileMap

var genThread

func _generateStuff(hello):
	randomize()
	for x in range(0,300,10):
		for y in range(0,150,2):
			if randi() % 40 > 7:
				for x2 in range(0,randi() % 15):
					if get_cell(x+x2,y-1)!=-1:
						set_cell(x+x2,y,1)
					else:
						set_cell(x+x2,y,0)
					for y2 in range(1,2):
						set_cell(x + x2,y + y2,1)
				x += randi() % 7 - 5

func _ready():
	genThread = Thread.new()
	genThread.start(self,"_generateStuff","")

func _physics_process(delta):
	for child in get_parent().get_parent().get_node("laOOOOVA INSTANCEs").get_children():
		var curEiPos = child.position
		if curEiPos != Vector2(0,0):
			for x in range(-4,4,1):
				for y in range(-4,4,1):
					set_cell((curEiPos.x + EiGlobal.chiggnPos.x) / 32 + x,(curEiPos.y + EiGlobal.chiggnPos.y) / 32 + y,-1)
			for x in range(-8,8):
				for y in range(-8,8):
					if randi() % 2>0:set_cell((curEiPos.x + EiGlobal.chiggnPos.x) / 32 + x,(curEiPos.y + EiGlobal.chiggnPos.y) / 32 + y,-1)
			curEiPos = Vector2(0,0)

		if LavaGlobal.pos != Vector2(0,0):
			for x in range(-5,5,1):
				for y in range(-5,5,1):
					set_cell((LavaGlobal.pos.x + LavaGlobal.lavaPos.x) / 32 + x,(LavaGlobal.pos.y + LavaGlobal.lavaPos.y) / 32 + y,-1)
