extends Resource
class_name  Dialog

@export_multiline var text = "..."
@export var options: Array[String]
@export var name: String = ""
@export var portrait: Texture2D = null
@export var voice_set: VoiceSet = null

func _init(p_text = "", p_options: Array[String] = [], p_portrait = null, p_voice_set = null):
	text = p_text
	options = p_options 
	portrait = p_portrait
	voice_set = p_voice_set
