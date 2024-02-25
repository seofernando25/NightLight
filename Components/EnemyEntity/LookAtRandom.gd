extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	var actor_char = actor as EnemyEntity
	var current_rotation = actor_char.vision_area.rotation

	# 1 in 5 changes of rotating 180
	var rotate_180 = randf() < 1.0 / 8.0
	if rotate_180:
		var rot_rad = current_rotation + deg_to_rad(180)
		blackboard.set_value("desired_rotation", rot_rad)
		return SUCCESS
	else:
		var random_rotation = randf_range(-45, 45)
		# Min 30 degrees rotation
		if random_rotation < 30 and random_rotation > -30:
			random_rotation = 30 if random_rotation > 0 else -30
		var rot_rad = current_rotation + deg_to_rad(random_rotation)
		blackboard.set_value("desired_rotation", rot_rad)

	return SUCCESS
