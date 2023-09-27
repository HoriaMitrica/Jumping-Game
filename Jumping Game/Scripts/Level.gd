extends Node3D

signal score_changed(new_score:int)
signal rotate

var platform=preload("res://Scenes/Platform.tscn")
var old_platform
var platform_name:String
var Score:int=0
var Combo_index=0
var platform_index=1

var next_platform_x:int=0
var next_platform_z:int=5

var min_distance:float=3
var max_distance:float=8
var direction_change:bool=false

var platform_zone
var combo_zone 	
var fall_zone
var platform_zone_path
var combo_zone_path 
var fall_zone_path
# Called when the node enter`s the scene tree for the first time.
func _ready():
	_change_signals("Platform1")

func _on_combo_event():
	Combo_index+=1
	_increaseScore(Combo_index*2)
	var x=_random_x()
	var z=_random_z()
	_instantiate(_get_new_pos(x,z))

func _on_landed_event():	
	Combo_index=0
	_increaseScore(1)
	var x=_random_x()
	var z=_random_z()
	_instantiate(_get_new_pos(x,z))
	
func _on_fall_event():
	get_tree().reload_current_scene()
	pass
	
func _instantiate(pos:Vector3):
	var instance=platform.instantiate()
	instance.position=pos
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
	#emit_signal("rotate")
	return randf_range(min_distance, max_distance)

func _change_signals(name:String):
	platform_zone_path=name+"/MeshInstance3D/PlatfformArea"
	platform_zone = get_node(platform_zone_path)
	platform_zone.landed_event.connect(_on_landed_event)
	
	combo_zone_path=name+"/ComboArea"
	combo_zone = get_node(combo_zone_path)
	combo_zone.combo_event.connect(_on_combo_event)
	
	fall_zone_path=name+"/FallArea"
	fall_zone = get_node(fall_zone_path)
	fall_zone.fall_event.connect(_on_fall_event)

func _process(delta):
	if platform_index>5:
		for i in range(1,4):
			platform_name="Platform"+str(i)
			old_platform=get_node(platform_name)
			old_platform.queue_free()
		print("nodes deleted")
		platform_index=0
		
		
