extends Camera2D
class_name MainCamera

static var instance: MainCamera = null

func _ready():
	if instance != null:
		push_error("MainCamera already exists")
		queue_free()
		return

	instance = self


@export var follow: Node2D = null
var step_x = 640
var step_y = 480


func _process(_delta):
	if follow:
		global_position = follow.global_position
		global_position.x = step_x * int(follow.global_position.x / step_x)
		global_position.y = step_y * int(follow.global_position.y / step_y)
	else:
		global_position = Vector2(0, 0)