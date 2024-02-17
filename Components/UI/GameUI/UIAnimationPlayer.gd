extends AnimationPlayer
class_name UIAnimationPlayer

static var instance: UIAnimationPlayer = null

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

func fade_out():
	print("fading out")
	play("fade_out")
	await animation_finished
	print("faded out")

func fade_in():
	print("fading in")
	play("fade_in")
	await animation_finished
	print("faded in")