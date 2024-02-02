extends Node2D
class_name SimpleDialogSlide

signal slide_finished

@export var dialog_text: String
@export var sprite_frames: SpriteFrames
@export var audio_stream: AudioStream

@onready var dialog: AudioStreamPlayer = $Dialog
@onready var background: AnimatedSprite2D = $Background
@onready var typewriter: Typewriter = $Typewriter

# Called when the node enters the scene tree for the first time.
var started = false
var freed = false
func start():
	if started:
		return
	started = true
	# Set up
	background.sprite_frames = sprite_frames
	dialog.stream = audio_stream
	typewriter.to_type = dialog_text

	await get_tree().create_timer(1).timeout
	if not freed:
		typewriter.start_typing()
	background.play("fade_in")
	dialog.play()

func _unhandled_input(event):
	if !started:
		return
	if event.is_action_pressed("ui_accept") and not freed:
		freed = true
		background.play("fade_out")
		typewriter.queue_free()
		background.speed_scale = 2
		await background.animation_finished
		emit_signal("slide_finished")

