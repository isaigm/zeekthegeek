extends Area2D
onready var map = get_node("../TileMap")
onready var globals = get_node("/root/Globals")


var moving = false
var direction = null
var speed = 45
var row
var col
var next_pos: Vector2

func is_blocked_left(player_col, player_row):
	return player_col == col and player_row == col and not globals.is_valid_cell(map, col - 1, row)

func is_blocked_right(player_col, player_row):
	return player_col == col and player_row == col and not globals.is_valid_cell(map, col + 1, row)

func is_blocked_up(player_col, player_row):
	return player_col == col and player_row == col and not globals.is_valid_cell(map, col, row - 1)
	
func is_blocked_down(player_col, player_row):
	return player_col == col and player_row == col and not globals.is_valid_cell(map, col, row + 1)



func _ready():
	pass
func update_pos(direction, dt):
	match direction:
		"right":
			position.x += dt * speed
			if position.x >= next_pos.x:
				position.x = next_pos.x
				moving = false
		"left":
			position.x -= dt * speed
			if position.x <= next_pos.x:
				position.x = next_pos.x
				moving = false
		"up":
			position.y -= dt * speed
			if position.y <= next_pos.y:
				position.y = next_pos.y
				moving = false

		"down":
			position.y += dt * speed
			if position.y >= next_pos.y:
				position.y = next_pos.y
				moving = false


func _process(dt):
	update_pos(direction, dt)

func on_move_player(rect, direction_):
	if rect.intersects(Rect2(position, Vector2(36, 36))) and not moving:
	
		direction = direction_
		var row_ = row
		var col_ = col
		match direction:
			"right":
				col_ += 1
			"left":
				col_ -= 1
			"up":
				row_ -= 1
			"down":
				row_ += 1
		if globals.is_valid_cell(map, col_, row_):
			moving = true
			col = col_
			row = row_
			print(str(col) + "," + str(row))
			next_pos = globals.get_pos(map, col, row)

func _on_Node2D_area_entered(area):
	pass

	
