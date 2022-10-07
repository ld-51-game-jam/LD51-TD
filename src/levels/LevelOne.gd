extends LevelHandler


func _ready() -> void:
	max_waves = 5
	wave_data = ["HumanEnemy", 4]
	counters_visible = true
	change_labels()

