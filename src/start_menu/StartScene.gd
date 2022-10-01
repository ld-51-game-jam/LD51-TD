extends Node2D


func _ready() -> void:
	$NewGame.color = Color.gray
	$QuitGame.color = Color.gray


func _on_NewGame_mouse_entered() -> void:
	$NewGame.color = Color.greenyellow


func _on_NewGame_mouse_exited() -> void:
	$NewGame.color = Color.gray


func _on_QuitGame_mouse_exited() -> void:
	$QuitGame.color = Color.gray


func _on_QuitGame_mouse_entered() -> void:
	$QuitGame.color = Color.greenyellow


func _on_NewGame_gui_input(event: InputEventMouseButton) -> void:
	# lets leave early if not the right event
	if event == null:
		return
		
	get_tree().change_scene("res://src/levels/LevelOne.tscn")
	
