extends Label
class_name Typewriter

signal typing_finished

@export var char_delay = 0.2
@export var autostart = false
@export var to_type = ""

var elapsed_chars = 0
@onready var timer: Timer = $Timer

func set_char_delay(delay):
	char_delay = delay
	timer.wait_time = char_delay

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.stop()
	timer.wait_time = char_delay
	text = ""

	if autostart:
		start_typing()

func start_typing():
	timer.wait_time = char_delay
	text = ""
	timer.start()

func skip_typing():
	timer.stop()
	text = to_type

func resume_typing():
	timer.start()

func stop_typing():
	timer.stop()
	elapsed_chars = 1
	
	
func _on_timer_timeout():
	elapsed_chars += 1
	text = to_type.left(elapsed_chars)
	if elapsed_chars == to_type.length():
		typing_finished.emit()
		timer.stop()
