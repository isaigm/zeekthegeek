extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var TILE_SIZE = 36
var col = 2 
var row = 5
var xspeed = 45

onready var tween = $Tween
onready var map = get_node("../Level1/TileMap")
var right = false
var left = false
var up = false
var down = false
var next_pos: Vector2
# Called when the node enters the scene tree for the first time.

func get_pos():
	return map.map_to_world(Vector2(col, row)) + Vector2.ONE * TILE_SIZE / 2

func _ready():
	position = get_pos()
	pass # Replace with function body.

func _input(event):
	if Input.is_key_pressed(KEY_RIGHT) and not right and not left and not up and not down:
		right = true
		$AnimatedSprite.play("right")
		col += 1
		next_pos = get_pos()
	elif Input.is_key_pressed(KEY_LEFT) and not right and not left and not up and not down:
		left = true
		$AnimatedSprite.play("left")
		col -= 1
		next_pos = get_pos()
	elif Input.is_key_pressed(KEY_UP) and not right and not left and not up and not down:
		up = true
		$AnimatedSprite.play("up")
		row -= 1
		next_pos = get_pos()
	elif Input.is_key_pressed(KEY_DOWN) and not right and not left and not up and not down:
		down = true
		$AnimatedSprite.play("down")
		row += 1
		next_pos = get_pos()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt):
	if right:
		position.x += dt * xspeed
		if position.x >= next_pos.x:
			position.x = next_pos.x
			right = false
			$AnimatedSprite.stop()
			$AnimatedSprite.set_frame(0)
	elif left:
		position.x -= dt * xspeed
		if position.x <= next_pos.x:
			position.x = next_pos.x
			left = false
			$AnimatedSprite.stop()
			$AnimatedSprite.set_frame(0)
	elif up:
		position.y -= dt * xspeed
		if position.y <= next_pos.y:
			position.y = next_pos.y
			up = false
			$AnimatedSprite.stop()
			$AnimatedSprite.set_frame(0)
	elif down:
		position.y += dt * xspeed
		if position.y >= next_pos.y:
			position.y = next_pos.y
			down = false
			$AnimatedSprite.stop()
			$AnimatedSprite.set_frame(0)
