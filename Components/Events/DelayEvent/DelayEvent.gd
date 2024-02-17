extends EventCommand

@export var t: float = 0.0

func Execute():
	print("Triggering delay of " + str(t) + " seconds")
	await get_tree().create_timer(t).timeout
	print("Delay finished")

