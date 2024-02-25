extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	var actor_char = actor as EnemyEntity
	var hearing_bodies = blackboard.get_value("hearing_bodies")
	hearing_bodies = hearing_bodies.filter(func(x): return x != null)
	blackboard.set_value("hearing_bodies", hearing_bodies)

	if hearing_bodies == null or hearing_bodies.size() == 0:
		return FAILURE

	var last_noise = hearing_bodies[hearing_bodies.size() - 1]

	var noise_direction = (last_noise.global_position - actor_char.global_position).normalized()
	blackboard.set_value("desired_rotation", noise_direction.angle())

	return SUCCESS
