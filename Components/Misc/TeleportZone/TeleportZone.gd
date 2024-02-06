extends Area2D

@export var teleport_to: Node2D
@export var animation_player: AnimationPlayer




func _on_body_entered(body:Node2D):
	if animation_player:
		PlayerFlags.movement_enabled = false
		animation_player.play("fade_out")
		await animation_player.animation_finished
		body.global_position = teleport_to.global_position
		PlayerFlags.movement_enabled = true
		animation_player.play("fade_in")

	else:
		body.global_position = teleport_to.global_position
