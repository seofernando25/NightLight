extends ActionLeaf

var found_noises = []


func _noise_dist(x: Node2D, actor: Node2D):
	return actor.global_position.distance_to(x.global_position)


func tick(actor, blackboard: Blackboard):
	# Filter out nulls
	var hearing_bodies = blackboard.get_value("hearing_bodies")
	hearing_bodies = hearing_bodies.filter(func(x): return x != null)
	blackboard.set_value("hearing_bodies", hearing_bodies)

	if hearing_bodies == null or hearing_bodies.size() == 0:
		return FAILURE

	var last_noise = hearing_bodies[hearing_bodies.size() - 1]
	var actor_char = actor as EnemyEntity
	actor_char.desired_position = last_noise.global_position

	var distance = actor_char.global_position.distance_to(actor_char.desired_position)
	if distance < 10:
		return SUCCESS

	return RUNNING
