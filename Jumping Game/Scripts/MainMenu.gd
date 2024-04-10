extends Control

var settings_scene = preload("res://Scenes/settings.tscn")
var GPGS
func ready():
	if Engine.has_singleton("GodotPlayGameServices"):
		GPGS=Engine.get_singleton("GodotPlayGameServices")
		GPGS.init(true,false,false,"")
		GPGS.connect("_on_sign_in_fail",_on_sign_in_success)
		GPGS.connect("_on_sign_in_fail",_on_sign_in_fail)

	pass
	
func _on_sign_in_success(userInfo):
	print("success "+userInfo)
	
func _on_sign_in_fail(errorCode:int):
	print("failed  "+str(errorCode))
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
		
	
func _on_setings_pressed():
	get_tree().change_scene_to_packed(settings_scene)


func _on_sign_in():
	if GPGS:
		GPGS.signIn();
	pass # Replace with function body.
