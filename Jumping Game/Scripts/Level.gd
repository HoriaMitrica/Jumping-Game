extends Node3D

signal settings
signal score_changed(new_score:int)
signal loose(new_score:int)
signal start
signal rotate()
signal landed()
signal center_offset(amount:int,forward:bool)

var platform=preload("res://Scenes/Platform.tscn")
var settings_scene = preload("res://Scenes/settings.tscn")
var materialChooser=preload("res://Scripts/MaterialResource.gd")
var old_platform
var platform_name:String
var Score:int=0
var Combo_index=0
var platform_index=1
var rotated:int=0
var next_platform_x:int=0
var next_platform_z:int=5

var min_distance:float=4
var max_distance:float=9
var direction_change:bool=false
var platform_zone
var combo_zone 	
var fall_zone
var platform_zone_path
var combo_zone_path 
var fall_zone_path
# Called when the node enter`s the scene tree for the first time.
func _ready():
	emit_signal("start")
	$CanvasLayer/LooseScreen.try_again.connect(_on_try_again)
	$CanvasLayer/LooseScreen.quit.connect(_on_quit)
	$CanvasLayer/GameUI.paused.connect(_on_paused)
	$CanvasLayer/PauseMenu.unpaused.connect(_on_unpaused)
	$CanvasLayer/PauseMenu.enter_settings.connect(_on_enter_settings)
	$CanvasLayer/Settings.back_to_game.connect(_on_back_to_game)
	_change_signals("Platform1")
	
func _on_back_to_game():
	$CanvasLayer/GameUI.visible=true
	$CanvasLayer/Settings.visible=false
		
func _on_enter_settings():
	emit_signal("settings")
	$CanvasLayer/Settings.visible=true
	$CanvasLayer/PauseMenu.visible=false
	
	
func _on_unpaused():
	$CanvasLayer/PauseMenu.visible=false
	$CanvasLayer/GameUI.visible=true
	
func _on_paused():
	$CanvasLayer/GameUI.visible=false
	$CanvasLayer/PauseMenu.visible=true
	
func _on_try_again():
	$CanvasLayer/GameUI.visible=true
	$CanvasLayer/LooseScreen.visible=false
	get_tree().paused=false
	get_tree().reload_current_scene()
	
func _on_quit():
	get_tree().paused=false
	get_tree().change_scene_to_file("res://Scenes/main_screen.tscn")
	
func _on_combo_event():
	Combo_index+=1
	emit_signal("landed")
	print("next_platform_x: ",next_platform_x)
	print("next_platform_z: ",next_platform_z)
	print("player x: ",$Player.position.x)
	print("player z: ",$Player.position.z)
	_increaseScore(Combo_index*2)
	var x=_random_x()
	var z=_random_z()
	$ComboText/SubViewport._change_text(Combo_index)
	$ComboText.position=$Player.position
	$ComboText.position.y+=2
	_instantiate(_get_new_pos(x,z))

func _on_landed_event():
	Combo_index=0
	emit_signal("landed")
	print("platform: ",next_platform_x)
	print("platform: ",next_platform_z)
	print("player x: ",$Player.position.x)
	print("player z: ",$Player.position.z)
	_increaseScore(1)
	var x=_random_x()
	var z=_random_z()
	_instantiate(_get_new_pos(x,z))
	
func _on_fall_event():
	emit_signal("loose",Score)
	$CanvasLayer/GameUI.visible=false
	$CanvasLayer/LooseScreen.visible=true
	pass
	
func _instantiate(pos:Vector3):
	var instance=platform.instantiate()
	instance.position=pos
	instance.rotation_degrees.y=randi_range(0,90)
	if(direction_change):
		emit_signal("center_offset",pos.z-$Player.position.z,!direction_change)
	else:
		emit_signal("center_offset",pos.x-$Player.position.x,!direction_change)
	
	#instance.scale = Vector3(0.5,1,0.5)
	platform_index+=1
	instance.name="Platform"+str(platform_index)
	add_child(instance)
	_change_signals(instance.name)
	
func _increaseScore(added_score:int):
	Score+=added_score
	emit_signal("score_changed",Score)
	
func _get_new_pos(x:float,z:float)->Vector3:
	next_platform_x+=x;
	next_platform_z+=z
	return Vector3(next_platform_x,0,next_platform_z)

func _random_x()->float:
	var new_direction = randi() % 2 == 0
	if new_direction!=direction_change:
		emit_signal("rotate")
		direction_change=new_direction
	if direction_change:
		return randf_range(min_distance, max_distance)
	return 0
func _random_z()->float:
	if direction_change:
		return 0
	return randf_range(min_distance, max_distance)

func _change_signals(name:String):
	var mesh=get_node(name+"/FoodTray")
	mesh.material_override=materialChooser.getRandomMaterial()
	platform_zone_path=name+"/FoodTray/PlatfformArea"
	platform_zone = get_node(platform_zone_path)
	platform_zone.landed_event.connect(_on_landed_event)
	
	combo_zone_path=name+"/ComboArea"
	combo_zone = get_node(combo_zone_path)
	combo_zone.combo_event.connect(_on_combo_event)
	
	fall_zone_path=name+"/FallArea"
	fall_zone = get_node(fall_zone_path)
	fall_zone.fall_event.connect(_on_fall_event)

func _process(delta):
	if platform_index>10:
		for i in range(1,9):
			platform_name="Platform"+str(i)
			old_platform=get_node(platform_name)
			old_platform.queue_free()
		print("nodes deleted")
		platform_index=0
		
