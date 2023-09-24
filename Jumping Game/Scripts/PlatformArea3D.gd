extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		if body.is_in_group("Player"):
			_on_player_entered_platform()

func _on_player_entered_platform():
	
