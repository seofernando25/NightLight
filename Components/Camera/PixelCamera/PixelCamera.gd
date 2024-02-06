extends Camera2D

@export var follow: Node2D = null
var step_x = 640
var step_y = 480

func _process(_delta):
	if follow:
		global_position = follow.global_position
		global_position.x = step_x * int(global_position.x / step_x)
		global_position.y = step_y * int(global_position.y / step_y)
