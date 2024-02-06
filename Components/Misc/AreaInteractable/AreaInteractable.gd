extends Area2D

@export var dialog  = Dialog.new("Hello, World!", ["Ok?", "Hello world!"])

func _on_body_entered(_body:Node2D):
	PlayerFlags.dialog_start.emit(dialog)
