extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
	
	


func _on_setings_pressed():
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")
