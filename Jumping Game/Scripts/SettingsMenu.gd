extends Control

signal back_to_game
var in_game_flag = false

func _on_back_pressed():
	if !in_game_flag:
		get_tree().change_scene_to_file("res://Scenes/main_screen.tscn")
	else:
		emit_signal("back_to_game")
		in_game_flag=false


func _on_level_settings():
	in_game_flag=true
