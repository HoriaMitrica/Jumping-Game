extends Control

signal paused

func _on_level_score_changed(score:int):
	$PanelContainer/MarginContainer/HBoxContainer/Label.text="Score: "+str(score)
	pass


func _on_pause_pressed():
	emit_signal("paused")
	get_tree().paused=true
