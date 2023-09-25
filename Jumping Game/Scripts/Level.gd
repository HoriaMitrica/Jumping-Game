extends Node3D

signal score_changed(new_score:int)
var platform=preload("res://Scenes/Platform.tscn")
var Score:int=0
var Combo_index=0
var platform_index=0

var next_platform_x:int=0
var next_platform_z:int=5

var min_distance:float=1
var max_distance:float=10
var direction_change:bool=false
var platform_zone
var combo_zone 
var platform_zone_path = "Platform/MeshInstance3D/PlatfformArea"
var combo_zone_path = "Platform/ComboArea"
# Called when the node enter`s the scene tree for the first time.
func _ready():
	_change_signals("Platform")

func _on_combo_event():
	Combo_index+=1
	_increaseScore(Combo_index*2)
	_instantiate(_get_new_pos(0,5))

func _on_landed_event():	
	Combo_index=0
	_increaseScore(1)
	var x=_random_x()
	var z=_random_z()
	_instantiate(_get_new_pos(x,z))
	
func _instantiate(pos:Vector3):
	var instance=platform.instantiate()
	instance.position=pos
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
	direction_change = randi() % 2 == 0
	if direction_change:
		return randf_range(min_distance, max_distance)
	return 0
func _random_z()->float:
	if direction_change:
		return 0
	return randf_range(min_distance, max_distance)

func _change_signals(name:String):
	platform_zone_path=name+"/MeshInstance3D/PlatfformArea"
	combo_zone_path=name+"/ComboArea"
	platform_zone = get_node(platform_zone_path)
	combo_zone = get_node(combo_zone_path)
	platform_zone.landed_event.connect(_on_landed_event)
	combo_zone.combo_event.connect(_on_combo_event)
