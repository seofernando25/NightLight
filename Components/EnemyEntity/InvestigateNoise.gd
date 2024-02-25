extends ActionLeaf

var overral_noise = 0.0


## Called when this node needs to be interrupted before it can return FAILURE or SUCCESS.
func interrupt(actor: Node, blackboard: Blackboard) -> void:
	pass


## Called before the first time it ticks by the parent.
func before_run(actor: Node, blackboard: Blackboard) -> void:
	overral_noise = FootstepNoise.total_noise()
	if overral_noise > 20:
		print("Noise th	reshold reached")


func tick(actor, blackboard: Blackboard):
	var actor_char = actor as EnemyEntity
	var hearing_bodies = blackboard.get_value("hearing_bodies")
	hearing_bodies = hearing_bodies.filter(func(x): return x != null)
	blackboard.set_value("hearing_bodies", hearing_bodies)

	if hearing_bodies == null or hearing_bodies.size() == 0:
		return FAILURE

	var last_noise = hearing_bodies[hearing_bodies.size() - 1]

	if overral_noise > 20:
		actor_char.desired_position = last_noise.global_position

		var distance = actor_char.global_position.distance_to(actor_char.desired_position)
		if distance < 10:
			return SUCCESS

		return RUNNING

	return FAILURE
