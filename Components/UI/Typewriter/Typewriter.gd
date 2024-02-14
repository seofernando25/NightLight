extends Label
class_name Typewriter

signal typing_finished
signal typing_started
signal on_type_char(character: String)

@export var char_delay = 0.2

func type_text(text_to_type):
	typing_started.emit()
	var txt = text_to_type
	text = ""

	if txt.length() == 0:
		return
	
	var index = 0

	for i in range(txt.length()):
		await get_tree().create_timer(char_delay).timeout
		index += 1
		text = txt.left(index)
		on_type_char.emit(txt[index - 1])

	typing_finished.emit()
	