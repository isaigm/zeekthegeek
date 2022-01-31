extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var picked = false
var curr_time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if picked:
		curr_time += delta
		if curr_time >= 0.15:
			queue_free()
			
func _on_Area2D_area_entered(area):
	picked = true
	$Sprite.region_rect = Rect2(0, 395, 36, 36)

