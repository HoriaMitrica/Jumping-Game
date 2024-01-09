extends Area3D

signal combo_event()
var Combo:bool=false
var Landed:bool=false
# Called when the node enters the scene tree for the first time.
func _ready():
	print(position.x)
	pass

func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("Player") && Landed==false && Combo==false:
			_on_player_entered_platform()

func _on_player_entered_platform():
	Combo=true
	print ("Combo")
	emit_signal("combo_event")
	
func _on_platfform_area_landed_event():
	Landed=true
	Combo=true
