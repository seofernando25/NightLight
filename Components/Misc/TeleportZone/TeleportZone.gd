extends Area2D
class_name TeleportZone

@export var zone_name: String = "default"
@export var teleport_to: String = "default"

func _ready():
	TeleportManager.setTeleportZone(zone_name + "_" + teleport_to, self)


func _on_body_entered(body:Node2D):
	# 1 second teleport cooldown
	if PlayerFlags.last_teleport_time + 1500 > Time.get_ticks_msec():
		print("TeleportZone: Teleport on cooldown")
		return
	PlayerFlags.last_teleport_time = Time.get_ticks_msec()
	var targetLocation = TeleportManager.getTeleportZone(teleport_to + "_" + zone_name)
	if not targetLocation:
		print("TeleportZone: No teleport zone found with name: " + teleport_to)
		return
	if PlayerFlags.ui_animation_player:
		PlayerFlags.movement_enabled = false
		PlayerFlags.ui_animation_player.play("fade_out")
		await PlayerFlags.ui_animation_player.animation_finished
		body.global_position = targetLocation.global_position
		PlayerFlags.movement_enabled = true
		PlayerFlags.ui_animation_player.play("fade_in")

	else:
		body.global_position = targetLocation.global_position
