extends Area3D

signal platform_event
var Combo:bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("Player") && Combo==false:
			_on_player_entered_platform()

func _on_player_entered_platform():
	print ("Combo")
	Combo=true;
	emit_signal("platform_event")
	
	
