extends Area3D

signal landed_event
var Landed:bool=false
var Combo:bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("Player") && Landed==false && Combo==false:
			_on_player_entered_platform()

func _on_player_entered_platform():
	Landed=true
	print("landed without combo")
	emit_signal("landed_event")

func _on_combo_area_combo_event():
	Combo=true
	Landed=true;
