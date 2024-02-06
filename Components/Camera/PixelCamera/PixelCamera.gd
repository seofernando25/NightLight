extends Camera2D

var pixel_size: int = 1


func _process(_delta):
	position = Vector2.ZERO
	var top_left = global_position - get_viewport_rect().size / 2
	top_left.x = int(top_left.x)
	top_left.y = int(top_left.y)

	# Set the camera position to the rounded top left corner
	global_position = top_left + get_viewport_rect().size / 2

