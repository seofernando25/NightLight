extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var sanity = float(PlayerFlags.sanity);

	# Sanity zoom effect
	var zoom_intensity = 0.0;
	# Map sanity 0-75 to 0.75-0
	if sanity > 75:
		zoom_intensity = 0;
	else:
		zoom_intensity = 0.75 - sanity / 100;

	material.set("shader_parameter/zoom_intensity", zoom_intensity);

	# Wobble effect
	var wobble_intensity = 0.0;

	# Map sanity 0-75 to 0 - 0.5
	if sanity > 75:
		wobble_intensity = 0;
	else:
		wobble_intensity = 0.5 - sanity / 150;

	
	material.set("shader_parameter/wobble_intensity", wobble_intensity);
	
	# Warp effect
	var warp_intensity = 0.0;
	if sanity < 50:
		warp_intensity = 1 - sanity / 50;
	else:
		warp_intensity = 0;

	material.set("shader_parameter/warp_intensity", warp_intensity);
