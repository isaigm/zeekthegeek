extends Node
var TILE_SIZE = 36
var walls = [0, 1, 2, 4, 5, 6, 7, 8]


func get_pos(map, col, row):
	return map.map_to_world(Vector2(col, row)) + Vector2.ONE * TILE_SIZE / 2

func is_valid_cell(map, x, y):
	return not map.get_cell(x, y) in walls 
	
	
func _ready():
	pass
