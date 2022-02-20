extends Node2D
signal move(rect, direction)

onready var map = get_node("../Level1/TileMap")
onready var globals = get_node("/root/Globals")
onready var animation = $AnimatedSprite
onready var movables = get_tree().get_nodes_in_group("movable")

var col = 2 
var row = 5
var speed = 45
var curr_dir = "right"
var moving = false
var next_pos: Vector2

func stop_animation():
	animation.stop()
	animation.set_frame(0)

func _ready():
	animation.play(curr_dir)
	stop_animation()
	position = globals.get_pos(map, col, row)

func _input(event):
	
	if Input.is_key_pressed(KEY_RIGHT) and not moving:
		if globals.is_valid_cell(map, col + 1, row) and can_move_right():
			moving = true
			curr_dir = "right"
			col += 1
	if Input.is_key_pressed(KEY_LEFT) and not moving:
		if globals.is_valid_cell(map, col - 1, row) and can_move_left():
			moving = true
			curr_dir = "left"
			col -= 1
	if Input.is_key_pressed(KEY_UP) and not moving:
		if globals.is_valid_cell(map, col, row - 1) and can_move_up():
			moving = true
			curr_dir = "up"
			row -= 1
	if Input.is_key_pressed(KEY_DOWN) and not moving:
		if globals.is_valid_cell(map, col, row + 1) and can_move_down():
			moving = true
			curr_dir = "down"
			row += 1
	if moving:
		animation.play(curr_dir)
		next_pos = globals.get_pos(map, col, row)

func _process(dt):
	emit_signal("move", Rect2(position, Vector2(globals.TILE_SIZE, globals.TILE_SIZE)), curr_dir)
	update_pos(dt)

func update_pos(dt):
	if not moving:
		return 
	match curr_dir:
		"right":
			position.x += dt * speed
			if position.x >= next_pos.x:
				position.x = next_pos.x
				moving = false
				stop_animation()
		"left":
			position.x -= dt * speed
			if position.x <= next_pos.x:
				position.x = next_pos.x
				moving = false
				stop_animation()
		"up":
			position.y -= dt * speed
			if position.y <= next_pos.y:
				position.y = next_pos.y
				moving = false
				stop_animation()
		"down":
			position.y += dt * speed
			if position.y >= next_pos.y:
				position.y = next_pos.y
				moving = false
				stop_animation()

func can_move_left():
	for m in movables:
		if m.is_blocked_left(col, row):
			return false
	return true

func can_move_right():
	for m in movables:
		if m.is_blocked_right(col, row):
			return false
	return true

func can_move_up():
	for m in movables:
		if m.is_blocked_up(col, row):
			return false
	return true

func can_move_down():
	for m in movables:
		if m.is_blocked_down(col, row):
			return false
	return true
