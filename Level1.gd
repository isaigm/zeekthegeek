extends Node2D
export (PackedScene) var Flower
export (PackedScene) var Apple
onready var map = $TileMap

func get_pos(map_pos: Vector2):
	return map.map_to_world(map_pos) + Vector2.ONE * 36 / 2

func _ready():
	var flowers_coords = [Vector2(5, 5), Vector2(7, 5), Vector2(12, 5), Vector2(14, 7), Vector2(2, 9), Vector2(6, 9), Vector2(8, 9), Vector2(9, 9), Vector2(11, 9)]
	for fcoords in flowers_coords:
		var flower = Flower.instance()
		flower.position = get_pos(fcoords)
		add_child(flower)
	
	var apple = Apple.instance()
	apple.position = get_pos(Vector2(11, 7))
	apple.row = 7
	apple.col = 11
	get_node("../Player").connect("move", apple, "on_move_player")
	add_child(apple)
#func _process(delta):
#	pass
