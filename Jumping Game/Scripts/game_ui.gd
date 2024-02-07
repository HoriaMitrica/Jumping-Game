extends Control

signal paused

func _on_level_score_changed(score:int):
	$PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Score.text="Score: "+str(score)
	pass
	
func _on_save_game(new_score:int):
	if(_on_load_game()<new_score):
		var save_game=FileAccess.open("user://savegame.save",FileAccess.WRITE)
		save_game.store_line(str(new_score))
		print("fileSaved")

func _on_load_game():
	print("file laod")
	if not FileAccess.file_exists("user://savegame.save"):
		return 0
	var save_game=FileAccess.open("user://savegame.save",FileAccess.READ)
	var score=save_game.get_line()
	$PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/HighScore.text="HighScore: "+score
	return score.to_int()
	
func _on_pause_pressed():
	emit_signal("paused")
	get_tree().paused=true
