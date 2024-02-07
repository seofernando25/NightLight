extends Resource
class_name  VoiceSet

@export var name = "default"
@export var noises: Array[AudioStream] = []

func _init(p_name: String = "", p_noises: Array[AudioStream] = []):
	name = p_name
	noises = p_noises
