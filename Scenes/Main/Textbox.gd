extends ColorRect

@onready var typewriter: Typewriter = %Text
@onready var portrait: TextureRect = %Portrait
@onready var hbox: HBoxContainer = %HBoxContainer
@onready var audioPlayer: AudioStreamPlayer = %AudioPlayer

var current_dialog: Dialog
var selected_option = 0

func _ready():
	PlayerFlags.dialog_start.connect(_on_dialog_start)
	typewriter.on_type_char.connect(_on_type_char)

func _on_type_char(character):
	# Ignore \n and space 
	if character == "\n" or character == " ":
		return

	# If current_dialog doesn't have a voice
	if not current_dialog.voice_set:
		return

	# Get a random index from voice_set
	var index = randi() % current_dialog.voice_set.noises.size()

	# Play the sound on the "TTS" channel
	var stream: AudioStream = current_dialog.voice_set.noises[index]
	audioPlayer.stream = stream
	# Set a random pitch between 0.8 and 1.6
	audioPlayer.pitch_scale = randf_range(0.8, 1.6)
	audioPlayer.play()

signal req_end_current_dialog
func _unhandled_input(event):
	if not current_dialog:
		return
	if  event.is_action_pressed("ui_left"):
		# Set modulation to white
		for i in range(hbox.get_child_count()):
			var label = hbox.get_child(i)
			label.modulate = Color(1, 1, 1, 1)
		selected_option -= 1
		# Wrap around to the last option
		if selected_option < 0:
			selected_option = current_dialog.options.size() - 1
		# Set the selected option's text to have an asterisk
		var child = hbox.get_child(selected_option)
		child.modulate = Color("#566154")
		

	if event.is_action_pressed("ui_right"):
		for i in range(hbox.get_child_count()):
			var label = hbox.get_child(i)
			label.modulate = Color(1, 1, 1, 1)
		selected_option += 1
		if selected_option > current_dialog.options.size() - 1:
			selected_option = 0
		# Set the selected option's text to have an asterisk
		var child = hbox.get_child(selected_option)
		child.modulate = Color("#566154")

	if event.is_action_pressed("ui_accept"):
		if is_dialoging:
			typewriter.set_char_delay(typewriter.char_delay * 0.5)
		req_end_current_dialog.emit()	

var is_dialoging = false



func _on_dialog_start(dialog: Dialog):
	selected_option = 0
	current_dialog = dialog
	# Kill all children of HBoxContainer
	for child in hbox.get_children():
		child.queue_free()
	# Add label for each option
	var n = 0
	for option in dialog.options:
		var label = Label.new()
		label.text = option
		if n == 0:
			label.modulate = Color("#566154")
		n += 1
		hbox.add_child(label)
	

	is_dialoging = true
	portrait.texture = dialog.portrait
	visible = true
	PlayerFlags.movement_enabled = false
	typewriter.text = ""
	typewriter.to_type = dialog.text
	typewriter.stop_typing()
	typewriter.start_typing()
	await typewriter.typing_finished
	await req_end_current_dialog
	PlayerFlags.movement_enabled = true
	typewriter.set_char_delay(0.05)
	visible = false
	is_dialoging = false
	PlayerFlags.dialog_end.emit(selected_option)

