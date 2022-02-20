extends Node2D
export (PackedScene) var Flower
export (PackedScene) var Apple
export (PackedScene) var Plant
onready var map = $TileMap
onready var globals = get_node("/root/Globals")

func _ready():
	var flowers_coords = [Vector2(5, 5), Vector2(7, 5), Vector2(12, 5), Vector2(14, 7), Vector2(2, 9), Vector2(6, 9), Vector2(8, 9), Vector2(9, 9), Vector2(11, 9)]
	var plants = [[Vector2(8, 6), "closed"], [Vector2(14, 10), "open"], [Vector2(3, 7), "closed"]]
	for coords in flowers_coords:
		var flower = Flower.instance()
		flower.position = globals.get_pos(map, coords.x, coords.y)
		add_child(flower)
	
	for plant in plants:
		var p = Plant.instance()
		p.col = plant[0].x
		p.row = plant[0].y
		p.state = plant[1]
		add_child(p)
	
	var apple = Apple.instance()
	apple.row = 7
	apple.col = 11
	get_node("../Player").connect("move", apple, "on_move_player")
	add_child(apple)
