extends Area2D
class_name LevelZone

@export var area_name = "area"
@export var points_of_interest_holder: Node2D = null


func _on_body_entered(body: Node2D):
	if body is EnemyEntity:
		var enemy = body as EnemyEntity

		var patrol_points: Array[Node2D] = []
		for point in points_of_interest_holder.get_children():
			patrol_points.append(point as Node2D)
		enemy.patrol_nodes = patrol_points
		print("Enemy Entered: ", area_entered)
