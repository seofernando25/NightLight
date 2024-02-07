extends Node

var teleportZones  = {}


# Get the TeleportZone associated with the given key.
func getTeleportZone(key: String) -> TeleportZone:
	return teleportZones.get(key) as TeleportZone

# Set the TeleportZone associated with the given key.
func setTeleportZone(key: String, teleportZone: TeleportZone):
	teleportZones[key] = teleportZone
