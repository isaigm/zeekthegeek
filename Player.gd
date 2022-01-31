extends Node2D
signal move(rect, direction, col, row)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var TILE_SIZE = 36
var col = 2 
var row = 5
var speed = 45
var curr_dir = "left"

onready var map = get_node("../Level1/TileMap")
onready var animation = $AnimatedSprite
var walls = [0, 1, 2, 4, 5, 6, 7, 8]
var right = false
var left = false
var up = false
var down = false
var next_pos: Vector2
var moving = false
func get_pos():
	return map.map_to_world(Vector2(col, row)) + Vector2.ONE * TILE_SIZE / 2

func is_valid_cell(x, y):
	return not map.get_cell(x, y) in walls 

func stop_animation():
	animation.stop()
	animation.set_frame(0)

func _ready():
	stop_animation()
	position = get_pos()

func _input(event):
	if Input.is_key_pressed(KEY_RIGHT) and not right and not moving:
		if is_valid_cell(col + 1, row):
			moving = true
			right = true
			curr_dir = "right"
			animation.play(curr_dir)
			col += 1
			next_pos = get_pos()
		
	if Input.is_key_pressed(KEY_LEFT) and not left and not moving:
		if is_valid_cell(col - 1, row):
			moving = true
			left = true
			curr_dir = "left"
			animation.play(curr_dir)
			col -= 1
			next_pos = get_pos()
	if Input.is_key_pressed(KEY_UP) and not up and not moving:
		if is_valid_cell(col, row - 1):
			moving = true
			up = true
			curr_dir = "up"
			animation.play(curr_dir)
			row -= 1
			next_pos = get_pos()
	if Input.is_key_pressed(KEY_DOWN) and not down and not moving:
		if is_valid_cell(col, row + 1):
			moving = true
			down = true
			curr_dir = "down"
			animation.play(curr_dir)
			row += 1
			next_pos = get_pos()
		

func _process(dt):
	emit_signal("move", Rect2(position, Vector2(TILE_SIZE, TILE_SIZE)), curr_dir, col, row)
	if right:
		position.x += dt * speed
		if position.x >= next_pos.x:
			position.x = next_pos.x
			right = false
			moving = false
			stop_animation()
	elif left:
		position.x -= dt * speed
		if position.x <= next_pos.x:
			position.x = next_pos.x
			left = false
			moving = false
			stop_animation()
	elif up:
		position.y -= dt * speed
		if position.y <= next_pos.y:
			position.y = next_pos.y
			up = false	
			moving = false
			stop_animation()
	elif down:
		position.y += dt * speed
		if position.y >= next_pos.y:
			position.y = next_pos.y
			down = false
			moving = false
			stop_animation()
