extends Control

signal unpaused
signal enter_settings
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_pressed():
	emit_signal("unpaused")
	get_tree().paused=false


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_screen.tscn")
	get_tree().paused=false


func _on_settings_pressed():
	emit_signal("enter_settings")
	get_tree().paused=false
