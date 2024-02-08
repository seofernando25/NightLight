extends Node

@export var control: Control

func _ready():
	if control:
		control.grab_focus()
