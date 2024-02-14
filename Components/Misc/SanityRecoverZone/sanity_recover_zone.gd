extends Area2D

@export var light_intensity = 1

func _on_body_exited(_body:Node2D):
	PlayerFlags.player_in_light -= light_intensity

func _on_body_entered(_body:Node2D):
	print("Player entered light")
	PlayerFlags.player_in_light += light_intensity
