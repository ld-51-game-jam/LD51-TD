extends Control


func _on_StartButton_pressed() -> void:
	GameData.hp = 5
	GameData.gold = 5
	get_tree().change_scene("res://src/levels/LevelOne.tscn")


func _on_OptionsButton_pressed() -> void:
	pass # @todo - add options scene menu

