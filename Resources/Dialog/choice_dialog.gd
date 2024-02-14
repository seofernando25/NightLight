extends Dialog
class_name  ChoiceDialog

@export var choices: Array[String] = []


func _init(p_text = "", p_portrait = null, p_voice_set = null):
	dialog_text = p_text
	portrait = p_portrait
	voice_set = p_voice_set
