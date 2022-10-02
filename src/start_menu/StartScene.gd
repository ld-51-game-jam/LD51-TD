extends Node2D

export(PackedScene) var EnemyScene

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
