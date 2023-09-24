extends Node3D

signal score_changed(new_score:int)
var Score:int=0
var platform
# Called when the node enters the scene tree for the first time.
func _ready():
	platform = get_node("Platform2/Area3D")
	#get_tree().platform.connect("platform_event", self, "_on_platform_event")
	platform.platform_event.connect(_on_platform_event)
	
func _on_platform_event():	
	print("Platform event received with value:")
	_increaseScore(2)
		
func _increaseScore(score:int):
	Score+=score
	emit_signal("score_changed",score)
