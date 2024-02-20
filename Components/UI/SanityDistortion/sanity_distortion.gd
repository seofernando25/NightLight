extends ColorRect

@export var interpolated_sanity_value = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Lerp used sanity value to the actual sanity value
	var lerp_amount = 0.5 * delta;
	if lerp_amount > 1:
		lerp_amount = 1;
	interpolated_sanity_value = lerp(interpolated_sanity_value, float(PlayerFlags.sanity), lerp_amount);

	# if difference is less than 0.1, set it to the actual value
	if abs(interpolated_sanity_value - float(PlayerFlags.sanity)) < 0.1:
		interpolated_sanity_value = float(PlayerFlags.sanity);

	var sanity = float(interpolated_sanity_value);

	if sanity < 0:
		sanity = 0;

	# Sanity zoom effect
	var zoom_intensity = 0.0;
	zoom_intensity =  1- sanity / 100.0;

	material.set("shader_parameter/zoom_intensity", zoom_intensity);

	# Wobble effect
	var wobble_intensity = 0.0;

	wobble_intensity = 1 - sanity / 100.0;

	
	material.set("shader_parameter/wobble_intensity", wobble_intensity);
	
	# Warp effect
	var warp_intensity = 1- sanity / 100.0;

	material.set("shader_parameter/warp_intensity", warp_intensity);
