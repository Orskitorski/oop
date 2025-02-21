extends Control

var Score = 0

func _ready():
	pass

func _on_RetryButton_pressed():
	Score = 0
	
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main.tscn")
		
func _on_QuitButton_pressed():
	get_tree().quit()
		
func handle_score(sc):
	Score += sc
		
