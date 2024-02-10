extends CharacterBody2D
class_name Player

static var instance: Player = null

func _ready():
	if instance == null:
		instance = self
		MainCamera.instance.follow = self
	else:
		print("Error: There are two players instances in the scene.")
		queue_free()