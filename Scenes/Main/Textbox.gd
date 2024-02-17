extends ColorRect
class_name DialogBox

@onready var typewriter: Typewriter = %Text
@onready var portrait: TextureRect = %Portrait
@onready var hbox: HBoxContainer = %HBoxContainer
@onready var audioPlayer: AudioStreamPlayer = %AudioPlayer

var current_dialog: Dialog
var selected_option = 0
static var in_dialog = false

var active_selection_color = Color("#ffffff")
var inactive_selection_color = Color("#1f1f1f")

func _ready():
	PlayerFlags.dialog_start.connect(_on_dialog_start)
	typewriter.on_type_char.connect(_on_type_char)

var speaking = false
func _on_type_char(character):
	# Ignore \n and space 
	if character == "\n" or character == " " or speaking:
		return

	# If current_dialog doesn't have a voice
	if not current_dialog.voice_set:
		return

	# Get a random index from voice_set
	var index = randi() % current_dialog.voice_set.noises.size()

	# Play the sound on the "TTS" channel
	var stream: AudioStream = current_dialog.voice_set.noises[index]
	audioPlayer.stream = stream
	audioPlayer.pitch_scale = randf_range(1, 1.6)
	audioPlayer.play()
	# speaking = true
	await audioPlayer.finished
	# speaking = false

signal req_end_current_dialog
func _unhandled_input(event):
	if not current_dialog:
		return

	if current_dialog is ChoiceDialog:
		if  event.is_action_pressed("ui_left"):
			if current_dialog.choices.size() == 0:
				return
			# Set modulation to white
			for i in range(hbox.get_child_count()):
				var label = hbox.get_child(i)
				label.modulate = inactive_selection_color
			selected_option -= 1
			# Wrap around to the last option
			if selected_option < 0:
				selected_option = current_dialog.choices.size() - 1
			# Set the selected option's text to have an asterisk
			var child = hbox.get_child(selected_option)
			child.modulate = active_selection_color
			

		if event.is_action_pressed("ui_right"):
			if current_dialog.choices.size() == 0:
				return
			for i in range(hbox.get_child_count()):
				var label = hbox.get_child(i)
				label.modulate = inactive_selection_color

			selected_option += 1
			if selected_option > current_dialog.choices.size() - 1:
				selected_option = 0
			# Set the selected option's text to have an asterisk
			var child = hbox.get_child(selected_option)
			child.modulate = active_selection_color

	if event.is_action_pressed("ui_accept"):
		if is_dialoging:
			typewriter.char_delay *= 0.5
		req_end_current_dialog.emit()	

var is_dialoging = false



func _on_dialog_start(dialog: Dialog):
	in_dialog = true
	selected_option = 0
	# Inherit previous properties
	if current_dialog and dialog.voice_set == null:
		dialog.voice_set = current_dialog.voice_set	
	if current_dialog and dialog.portrait == null:
		dialog.portrait = current_dialog.portrait


	current_dialog = dialog
	
	# Kill all children of HBoxContainer
	for child in hbox.get_children():
		child.queue_free()

	if dialog is ChoiceDialog:
		print("ChoiceDialog")
		var n = 0
		for option in dialog.choices:
			var label = Label.new()
			label.text = option
			if n == 0:
				label.modulate = active_selection_color
			else:
				label.modulate = inactive_selection_color
			n += 1
			hbox.add_child(label)


	# # Add label for each option
	

	is_dialoging = true
	portrait.texture = dialog.portrait
	visible = true
	typewriter.char_delay = 0.05
	typewriter.type_text(dialog.dialog_text)
	await typewriter.typing_finished
	await req_end_current_dialog
	visible = false
	is_dialoging = false
	in_dialog = false
	PlayerFlags.dialog_end.emit(selected_option)
	print("Textbox Dialog ended")

