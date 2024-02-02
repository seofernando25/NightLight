extends Node2D

@export var slides: Array[SimpleDialogSlide] = []
var current_slide = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set all slides to be hidden but the first one.
	for slide in slides:
		slide.visible = false
	slides[0].visible = true

	# 0.5 seconds delay before starting the dialog.
	await get_tree().create_timer(0.5).timeout
	for slide in slides:

		for slide_to_hide in slides:
			slide_to_hide.visible = false
		
		slide.visible = true

		print("Starting slide")
		slide.start()
		await slide.slide_finished
		print("Slide finished")
	
	print("Dialog finished")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
