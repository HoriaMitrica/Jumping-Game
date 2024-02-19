extends Control

signal try_again
signal quit
# Called when the node enters the scene tree for the first time.
func _on_quit_pressed():
	emit_signal("quit")

	
func _on_try_again_pressed():
	emit_signal("try_again")
