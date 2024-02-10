extends Area2D
class_name TeleportZone


static var teleportZones  = {}

# Get the TeleportZone associated with the given key.
func getTeleportZone(key: String) -> TeleportZone:
	return teleportZones.get(key) as TeleportZone

# Set the TeleportZone associated with the given key.
func setTeleportZone(key: String, teleportZone: TeleportZone):
	teleportZones[key] = teleportZone



static var last_teleport_time: int = 0

@export var zone_name: String = "default"
@export var teleport_to: String = "default"

func _ready():
	setTeleportZone(zone_name + "_" + teleport_to, self)


func _on_body_entered(body:Node2D):
	# 1 second teleport cooldown
	if last_teleport_time + 1500 > Time.get_ticks_msec():
		print("TeleportZone: Teleport on cooldown")
		return
	last_teleport_time = Time.get_ticks_msec()
	var targetLocation = getTeleportZone(teleport_to + "_" + zone_name)
	if not targetLocation:
		print("TeleportZone: No teleport zone found with name: " + teleport_to)
		return
	if UIAnimationPlayer.instance:
		PlayerMovement.controller_enabled = false
		UIAnimationPlayer.instance.play("fade_out")
		await UIAnimationPlayer.instance.animation_finished
		body.global_position = targetLocation.global_position
		PlayerMovement.controller_enabled = true
		UIAnimationPlayer.instance.play("fade_in")
	else:
		print("TeleportZone: No UIAnimationPlayer found")
		body.global_position = targetLocation.global_position
