extends LevelHandler


func _ready() -> void:
	wave_data = ["Enemy", 10]
	$AnimationPlayer.play("Titlecard")

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
