extends Resource
class_name  Dialog

@export var text = "Hello, World!"
@export var options = ["Option 1", "Option 2", "Option 3"]
@export var portrait: Texture2D = null

func _init(p_text = "", p_options = [], p_portrait = null):
	text = p_text
	options = p_options
	portrait = p_portrait