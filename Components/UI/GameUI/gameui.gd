extends CanvasLayer
class_name GameUI

static var instance:GameUI

func _ready():
	if instance == null:
		instance = self
	else:
		push_error("There are multiple instances of GameUI in the scene.")
		queue_free()

