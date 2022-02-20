extends Area2D
onready var map = get_node("../TileMap")
onready var globals = get_node("/root/Globals")
onready var eatables = get_tree().get_nodes_in_group("eatable")
onready var animation = $AnimatedSprite
var state = "closed"
var row: int
var col: int

func _ready():
	position = globals.get_pos(map, col, row)
	
	if state == "open":
		animation.play("open")
		animation.stop()
		animation.set_frame(3)

func can_eat():
	if state == "closed":
		for eatable in eatables:
			if eatable.row == row - 1 and eatable.col == col or \
			eatable.row == row + 1 and eatable.col == col or \
			eatable.col == col - 1 and eatable.row == row or \
			eatable.col == col + 1 and eatable.row == row:
				animation.play("open")
				break

func _process(delta):
	can_eat()
	eat()

func eat():
	if state == "open":
		for eatable in eatables:
			var xcentered = abs(eatable.position.x - position.x) <= 0.3
			var ycentered = abs(eatable.position.y - position.y) <= 0.3
			var close_enough_y_up    = abs(eatable.position.y + globals.TILE_SIZE - position.y) <= 10
			var close_enough_y_down  = abs(eatable.position.y - (position.y + globals.TILE_SIZE)) <= 10
			var close_enough_x_left  = abs(eatable.position.x + globals.TILE_SIZE - position.x) <= 10
			var close_enough_x_right = abs(eatable.position.x - globals.TILE_SIZE - position.x) <= 10
			var must_eat = false 
			if  xcentered and close_enough_y_up:
				must_eat = true
				position.y = globals.TILE_SIZE * row  
				animation.play("eat_player_up")
			if  xcentered and close_enough_y_down: 
				must_eat = true
				position.y = globals.TILE_SIZE * (row + 1)
				animation.play("eat_player_down")
			if  close_enough_x_left and ycentered: 
				must_eat = true
				position.x = globals.TILE_SIZE * col  
				animation.play("eat_player_left")
			if  close_enough_x_right and ycentered: 
				must_eat = true
				position.x = globals.TILE_SIZE * (col + 1)  
				animation.play("eat_player_right")
			if must_eat:
				eatable.set_visible(false)
				state = "extended"
				$ExtendedTimer.start()

func stop_animation():
	animation.stop()
	animation.set_frame(0)

func _on_AnimatedSprite_animation_finished():
	match animation.get_animation():
		"open":
			animation.stop()
			animation.set_frame(3)
			state = "open"
		"eat_player_up":
			stop_animation()
		"eat_player_down":
			stop_animation()
		"eat_player_left":
			stop_animation()
		"eat_player_right":
			stop_animation()
		"eating_player":
			stop_animation()

func _on_ExtendedTimer_timeout():
	position = globals.get_pos(map, col, row)
	animation.play("eating_player")
	stop_animation()
	$EatingPlayerTimer.start()

func _on_EatingPlayerTimer_timeout():
	animation.play("eating_player")
