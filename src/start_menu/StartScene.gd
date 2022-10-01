extends Node2D


func _ready() -> void:
	$TileMap/NewGame.color = Color.gray
	$TileMap/QuitGame.color = Color.gray
	$TileMap/Help.color = Color.gray


func _on_NewGame_mouse_entered() -> void:
	$TileMap/NewGame.color = Color.lemonchiffon


func _on_NewGame_mouse_exited() -> void:
	$TileMap/NewGame.color = Color.gray


func _on_QuitGame_mouse_exited() -> void:
	$TileMap/QuitGame.color = Color.gray


func _on_QuitGame_mouse_entered() -> void:
	$TileMap/QuitGame.color = Color.lemonchiffon


func _on_Help_mouse_entered() -> void:
	$TileMap/Help.color = Color.lemonchiffon


func _on_Help_mouse_exited() -> void:
	$TileMap/Help.color = Color.gray


# looking for a NewGame mouse click
func _on_NewGame_gui_input(event: InputEventMouseButton) -> void:
	# lets leave early if not the right event
	if event == null:
		return
		
	get_tree().change_scene("res://src/levels/LevelOne.tscn")


# looking for a QuitGame mouse click
func _on_QuitGame_gui_input(event: InputEventMouseButton) -> void:
	# lets leave early if not the right event
	if event == null:
		return
		
	queue_free()
	get_tree().quit()


# My high-2am thought here:
# We should decide if we should have a small help UI to show what does what?
func _on_Help_gui_input(event: InputEventMouseButton) -> void:
	pass

