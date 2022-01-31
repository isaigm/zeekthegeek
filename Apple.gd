extends Area2D
onready var map = get_node("../TileMap")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func get_pos(map_pos: Vector2):
	return map.map_to_world(map_pos) + Vector2.ONE * 36 / 2

var must_move = false
var direction = null
var speed = 45
var row
var col
var next_pos: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(dt):
	if must_move:
		match direction:
			"right":
				position.x += dt * speed
				if position.x >= next_pos.x:
					position.x = next_pos.x
					
			"left":
				position.x -= dt * speed
				if position.x <= next_pos.x:
					position.x = next_pos.x
					
			"up":
				position.y -= dt * speed
				if position.y <= next_pos.y:
					position.y = next_pos.y
				
			"down":
				position.y += dt * speed
				if position.y >= next_pos.y:
					position.y = next_pos.y
					
func on_move_player(rect, direction_, col_, row_):
	if rect.intersects(Rect2(position, Vector2(36, 36))):
		direction = direction_
		row = row_
		col = col_
		must_move = true
		match direction:
			"right":
				col += 1
			"left":
				col -= 1
			"up":
				row -= 1
			"down":
				row += 1
		next_pos = get_pos(Vector2(col, row))


func _on_Node2D_area_entered(area):
	pass

	
