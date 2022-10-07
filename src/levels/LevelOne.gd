extends LevelHandler


func _ready() -> void:
	max_waves = 3
	wave_data = ["Enemy", 4]
	counters_visible = true
	change_labels()

