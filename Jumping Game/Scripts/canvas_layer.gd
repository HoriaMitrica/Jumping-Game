extends CanvasLayer


func _on_level_score_changed(new_score):
	$ScoreText.text="SCORE: "+str(new_score)
