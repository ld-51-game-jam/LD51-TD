extends LevelHandler


func _ready() -> void:
	wave_data = [["Enemy", 0.9],["Enemy", 0.8],["Enemy", 0.7],["Enemy", 0.6],["Enemy", 0.5],["Enemy", 0.4],["Enemy", 0.3],["Enemy", 0.2],["Enemy", 0.1]]

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
