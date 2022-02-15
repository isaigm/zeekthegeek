extends Node2D
signal move(rect, direction)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var map = get_node("../Level1/TileMap")
onready var globals = get_node("/root/Globals")
onready var animation = $AnimatedSprite
onready var movables = get_tree().get_nodes_in_group("movable")

var col = 2 
var row = 5
var speed = 45
var curr_dir = "left"

var right = false
var left = false
var up = false
var down = false
var moving = false
var next_pos: Vector2

func stop_animation():
	animation.stop()
	animation.set_frame(0)

func _ready():
	stop_animation()
	position = globals.get_pos(map, col, row)

func _input(event):
	if Input.is_key_pressed(KEY_RIGHT) and not right and not moving:
		if globals.is_valid_cell(map, col + 1, row):
			moving = true
			right = true
			curr_dir = "right"
			animation.play(curr_dir)
			col += 1
			next_pos = globals.get_pos(map, col, row)
		
	if Input.is_key_pressed(KEY_LEFT) and not left and not moving:
		if globals.is_valid_cell(map, col - 1, row):
			moving = true
			left = true
			curr_dir = "left"
			animation.play(curr_dir)
			col -= 1
			next_pos = globals.get_pos(map, col, row)
	if Input.is_key_pressed(KEY_UP) and not up and not moving:
		if globals.is_valid_cell(map, col, row - 1):
			moving = true
			up = true
			curr_dir = "up"
			animation.play(curr_dir)
			row -= 1
			next_pos = globals.get_pos(map, col, row)
	if Input.is_key_pressed(KEY_DOWN) and not down and not moving:
		if globals.is_valid_cell(map, col, row + 1):
			moving = true
			down = true
			curr_dir = "down"
			animation.play(curr_dir)
			row += 1
			next_pos = globals.get_pos(map, col, row)

func _process(dt):
	emit_signal("move", Rect2(position, Vector2(globals.TILE_SIZE, globals.TILE_SIZE)), curr_dir)
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
