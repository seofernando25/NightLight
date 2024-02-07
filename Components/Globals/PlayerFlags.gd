extends Node

signal dialog_start(dialog: Dialog)
signal dialog_end(option: int)

var movement_enabled = true

var last_teleport_time = 0
var ui_animation_player: AnimationPlayer = null