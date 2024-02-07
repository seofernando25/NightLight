extends Node2D




func _on_sink_interact():
	print("Interact")
	PlayerFlags.misc_flags["sink_interact"] = true
