extends Resource
class_name  Dialog

enum DialogType {
	TEXT, OPTIONS
}


@export var dialog_type = DialogType.TEXT
@export_multiline var dialog_text = "..."
@export var option_text: String = ""

@export var options: Array[Dialog] = []
@export var name: String = ""
@export var portrait: Texture2D = null
@export var voice_set: VoiceSet = null
@export var next: Dialog = null

func _init(p_text = "", p_options: Array[Dialog] = [],
		 p_portrait = null, p_voice_set = null, p_next = null, p_option_text = ""):
	option_text = p_option_text
	dialog_text = p_text
	options = p_options 
	portrait = p_portrait
	voice_set = p_voice_set
	next = p_next
