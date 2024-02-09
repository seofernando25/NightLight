extends Node

@export var nav_agent: NavigationAgent2D
@export var target: Vector2 = Vector2(0, 0)

@export var speed: float = 100

func _ready():
	call_deferred("nav_setup")


func nav_setup():
	await get_tree().physics_frame
	set_movement_target(target)

func set_movement_target(target_p: Vector2):
	nav_agent.target_position = target_p

func _physics_process(_delta):
	if nav_agent.is_navigation_finished():
		return

	var parent: CharacterBody2D = get_parent() 
	var current_agent_pos = parent.global_position
	var next_path_position = nav_agent.get_next_path_position()
	var new_velocity = (next_path_position - current_agent_pos).normalized() * speed
	parent.velocity = new_velocity
	parent.move_and_slide()
