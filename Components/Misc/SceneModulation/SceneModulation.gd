extends CanvasModulate
class_name SceneModulation

static var instance = null

func _ready():
	if instance == null:
		instance = self
	else:
		print("There is already a SceneModulation instance")
		self.queue_free()

