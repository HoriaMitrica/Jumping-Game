extends Node2D
func save_game(new_score:int):
	var save_game=FileAccess.open("user://savegame.save",FileAccess.WRITE)
	var json_strring=JSON.stringify
	save_game.store_line(str(new_score))

func ready():
	save_game(20)

