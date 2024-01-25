extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _change_text(amount:int):
	get_node("Label").text="Combo!\n X "+str(amount)
