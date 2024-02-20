extends EventCommand

@export var to_move: Node2D = null
@export var pivot_a: Node2D = null
@export var pivot_b: Node2D = null

func Execute():
	if to_move == null or pivot_a == null or pivot_b == null:
		push_error("One of the nodes is not set")
		return
	
	var diff = pivot_a.global_position - to_move.global_position
	to_move.global_position = pivot_b.global_position - diff
	print("Moved " + to_move.name + " from " + pivot_a.name + " to " + pivot_b.name)