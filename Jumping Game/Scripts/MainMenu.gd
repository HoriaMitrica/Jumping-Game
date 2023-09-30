extends Control

var settings_scene = preload("res://Scenes/settings.tscn")

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
	
	
func _on_setings_pressed():
	get_tree().change_scene_to_packed(settings_scene)
