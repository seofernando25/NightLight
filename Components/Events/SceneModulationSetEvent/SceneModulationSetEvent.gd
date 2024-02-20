extends EventCommand

@export var color: Color = Color(1, 1, 1, 1)
@export var t: float = 0.5

func Execute():
	if SceneModulation.instance == null:
		push_error("SceneModulation node has not been instantiated")
		return
	print("Modulating scene color to " + str(color) + " over " + str(t) + " seconds")
	var end_time = Time.get_ticks_msec() + t * 1000
	var start_color = SceneModulation.instance.color

	while Time.get_ticks_msec() < end_time:
		var elapsed = end_time - Time.get_ticks_msec()
		var percent = 1 - elapsed / (t * 1000)
		SceneModulation.instance.color = start_color.lerp(color, percent)
		await get_tree().process_frame
	
	print("Modulation complete")
	SceneModulation.instance.color = color
