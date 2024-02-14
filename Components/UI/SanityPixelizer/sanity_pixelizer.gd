extends ColorRect


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var sanity = PlayerFlags.sanity
	var pixel_size = 0.5

	if sanity < 50:
		pixel_size = 4
	

	material.set("shader_parameter/size", Vector2(pixel_size, pixel_size))