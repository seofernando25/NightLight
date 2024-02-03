extends Node

@export var animated_sprite: AnimatedSprite2D
@export var rigid_body: CharacterBody2D

var flip_y = -1
var flip_x = 1
var last_side = 0

func is_moving(val):
	return abs(val) > 10


func _process(_delta):
	if is_moving(rigid_body.velocity.y):
		last_side = 0
		if rigid_body.velocity.y < 0:
			animated_sprite.play("walk_back")
			flip_y = -1
		else:
			animated_sprite.play("walk_foward")
			flip_y = 1
		return
	if is_moving(rigid_body.velocity.x):
		last_side = 1
		if rigid_body.velocity.x > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("walk_side")
			flip_x = -1
		else:
			animated_sprite.flip_h = true
			animated_sprite.play("walk_side")
			flip_x = 1
		return
	
	
	if rigid_body.velocity.x == 0 and rigid_body.velocity.y == 0:
		if last_side == 1:
			animated_sprite.play("idle_side")
			animated_sprite.flip_h = flip_x == 1
		else:
			if flip_y == 1:
				animated_sprite.play("idle_foward")
			else:
				animated_sprite.play("idle_back")
			
