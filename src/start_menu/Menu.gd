extends Control


func _on_StartButton_pressed():
	GameData.hp = 5
	GameData.gold = 5
	get_tree().change_scene("res://src/levels/LevelOne.tscn")


func _on_OptionsButton_pressed():
	pass # Replace with function body.

