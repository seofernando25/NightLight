extends AnimationPlayer
class_name UIAnimationPlayer

static var instance = null

func _ready():
	if instance == null:
		instance = self
	else:
		print("UIAnimationPlayer already exists")
		queue_free()


func _exit_tree():
	if instance == self:
		print("UIAnimationPlayer is exiting")
		instance = null