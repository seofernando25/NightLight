extends Resource
class_name  Dialog

enum DialogType {
	TEXT, OPTIONS
}

@export_multiline var dialog_text = "..."

@export var portrait: Texture2D = null
@export var voice_set: VoiceSet = null

func _init(p_text = "", p_portrait = null, p_voice_set = null):
	dialog_text = p_text
	portrait = p_portrait
	voice_set = p_voice_set
