extends Area3D

signal fall_event
var falling:bool=false

func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("Player") && !falling:
			_on_player_entered_platform()

func _on_player_entered_platform():
	falling=true
	emit_signal("fall_event")

