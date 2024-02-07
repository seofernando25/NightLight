extends Area2D

@export var introScene: PackedScene


func play_intro():
	get_tree().change_scene_to_packed(introScene)

func _on_body_entered(_body:Node2D):
	call_deferred("play_intro")
