
extends Node2D

func _ready():
	OS.set_window_position(OS.get_screen_size()/2-OS.get_window_size()/2)
	set_process_input(true)
	pass

func _input(event):
	var reset_game = Input.is_key_pressed(KEY_R)
	if reset_game:
		get_tree().change_scene("res://scenes/lvl1.scn")