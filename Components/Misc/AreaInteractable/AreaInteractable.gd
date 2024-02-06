extends Area2D

@export var text: String = "Hello, World!"


func _on_body_entered(body:Node2D):
	print("Hello, World!")
